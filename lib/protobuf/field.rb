require 'protobuf/wire_type'

module Protobuf
  module Field
    def self.build(message_class, rule, type, name, tag, opts={})
      Base.build message_class, rule, type, name, tag, opts
    end

    class InvalidRuleError < StandardError; end

    class Base
      class <<self
        def build(message_class, rule, type, name, tag, opts={})
          field_class = nil
          begin
            field_class = eval "Protobuf::Field::#{type.to_s.capitalize}Field"
          rescue NameError
            type = typename_to_class message_class, type
            field_class =
              if type.superclass == Protobuf::Enum
                Protobuf::Field::Enum
              elsif type.superclass == Protobuf::Message
                Protobuf::Field::Message
              else
                raise $!
              end
          end
          field_class.new message_class, rule, type, name, tag, opts
        end

        def typename_to_class(message_class, type)
          modules = message_class.to_s.split('::')
          while
            begin
              type = eval((modules | [type.to_s]).join('::'))
              break
            rescue NameError
              modules.empty? ? raise($!) : modules.pop
            end
          end
          type
        end
      end

      attr_accessor :message_class, :rule, :type, :name, :tag, :default

      def initialize(message_class, rule, type, name, tag, opts={})
        @message_class, @rule, @type, @name, @tag, @default = 
          message_class, rule, type, name, tag, opts[:default]
        @error_message = 'Type invalid'
      end

      def default_value
        case rule
        when :repeated
          FieldArray.new self
        when :required, :optional
          typed_default_value default
        else
          raise InvalidRuleError
        end
      end

      def typed_default_value(default=nil)
        default
      end

      def define_accessor(message_instance)
        message_instance.instance_variable_set "@#{name}", default_value
        define_getter message_instance
        define_setter message_instance unless rule == :repeated
      end

      def define_getter(message_instance)
        message_instance.instance_eval %Q{
          def #{name}
            @#{name}
          end
        }
      end

      def define_setter(message_instance)
        message_instance.instance_eval %Q{
          def #{name}=(val)
            field = get_field_by_name #{name.inspect}
            if field.acceptable? val
              @#{name} = val
            end
          end
        }
      end

      def set(message_instance, bytes)
        if repeated?
          set_array message_instance, bytes
        else
          set_bytes message_instance, bytes
        end
      end

      def set_array(message_instance, bytes)
        raise NotImplementedError
      end

      def set_bytes(message_instance, bytes)
        raise NotImplementedError
      end

      def get(value)
        get_bytes value
      end

      def get_bytes(value)
        raise NotImplementedError
      end

      def merge(message_instance, bytes)
        if repeated?
          merge_array method_instance, bytes
        else
          merge_value method_instance, bytes
        end
      end

      def merge_array(message_instance, bytes)
        raise NotImplementedError
      end

      def merge_value(message_instance, bytes)
        raise NotImplementedError
      end

      def repeated?; rule == :repeated end
      def required?; rule == :required end
      def optional?; rule == :optional end

      def max; self.class.max end
      def min; self.class.min end

      def acceptable?(val)
        true
      end

      def error_message
        @error_message
      end

      def to_s
        "#{rule} #{type} #{name} = #{tag} #{default ? "[default=#{default}]" : ''}"
      end
    end

    class FieldArray < Array
      def initialize(field)
        @field = field
      end

      def []=(nth, val)
        if @field.acceptable? val
          super
        end
      end

      def <<(val)
        if @field.acceptable? val
          super
        end
      end

      def push(val)
        if @field.acceptable? val
          super
        end
      end

      def unshift(val)
        if @field.acceptable? val
          super
        end
      end

      def to_s
        "[#{@field.name}]"
      end
    end

    class StringField < Base
      def wire_type
        Protobuf::WireType::LENGTH_DELIMITED
      end

      def typed_default_value(default=nil)
        default or ''
      end

      def acceptable?(val)
        raise TypeError unless val.instance_of? String
        true
      end

      def set_bytes(method_instance, bytes)
        method_instance.send("#{name}=", bytes.to_string)
      end

      def get_bytes(value)
        bytes = value.unpack('U*')
        string_size = Int.get_bytes bytes.size
        string_size + bytes
      end
    end
    
    class BytesField < Base
      def wire_type
        Protobuf::WireType::VARINT
      end

      def typed_default_value(default=nil)
        default or ''
      end
    end

    class Int < Base
      def wire_type
        Protobuf::WireType::VARINT
      end

      def typed_default_value(default=nil)
        default or 0
      end
 
      def set_bytes(method_instance, bytes)
        method_instance.send("#{name}=", bytes.to_varint)
      end

      def self.get_bytes(value)
        # TODO should refactor using unpack('w*')
        #return [value].pack('w*').unpack('C*')
        bytes = []
        until value == 0
          byte = 0
          7.times do |i|
            byte |= (value & 1) << i
            value >>= 1
          end
          byte |= 0b10000000
          bytes << byte
        end
        #bytes[0] &= 0b01111111
        #bytes
        bytes[bytes.size - 1] &= 0b01111111
        bytes
      end

      def get_bytes(value)
        self.class.get_bytes value
      end

      def acceptable?(val)
        raise TypeError unless val.is_a? Integer
        raise RangeError if val < min or max < val
        true
      end
    end
    
    class Int32Field < Int
      def self.max; 1.0/0.0 end
      def self.min; -1.0/0.0 end
    end
    
    class Int64Field < Int
      def self.max; 1.0/0.0 end
      def self.min; -1.0/0.0 end
    end
    
    class Uint32Field < Int
      def self.max; 1.0/0.0 end
      def self.min; 0 end
    end
    
    class Uint64Field < Int
      def self.max; 1.0/0.0 end
      def self.min; 0 end
    end
    
    class Sint32Field < Int
      def self.max; 1.0/0.0 end
      def self.min; -1.0/0.0 end
    end
    
    class Sint64Field < Int
      def self.max; 1.0/0.0 end
      def self.min; -1.0/0.0 end
    end
    
    class DoubleField < Int
      def wire_type
        Protobuf::WireType::FIXED64
      end
 
      #TODO
      def self.max
        '0x7fefffffffffffff'.unpack('f').first
      end

      #TODO
      def self.min
        -(2**(64/2) - 1)
      end

      def acceptable?(val)
        raise TypeError unless val.is_a? Numeric
        raise RangeError if val < min or max < val
        true
      end
    end
    
    class FloatField < Int
      def wire_type
        Protobuf::WireType::FIXED32
      end
 
      #TODO
      def self.max
        '0x7fefffffffffffff'.unpack('f').first
      end

      #TODO
      def self.min
        -(2**(64/2) - 1)
      end
 
      def acceptable?(val)
        raise TypeError unless val.is_a? Numeric
        raise RangeError if val < min or max < val
        true
      end
   end
    
    class Fixed32Field < Int
      def wire_type
        Protobuf::WireType::FIXED32
      end

      def self.max
        2**32
      end

      def self.min
        0
      end
    end
    
    class Fixed64Field < Int
      def wire_type
        Protobuf::WireType::FIXED64
      end

      def self.max
        2**64
      end

      def self.min
        0
      end
    end
    
    class Sfinxed32Field < Int
      def wire_type
        Protobuf::WireType::FIXED32
      end

      def self.max
        2**(32/2)
      end

      def self.min
        -(2**(32/2) - 1)
      end
    end
    
    class Sfixed64Field < Int
      def wire_type
        Protobuf::WireType::FIXED64
      end

      def self.max
        2**(64/2)
      end

      def self.min
        -(2**(64/2) - 1)
      end
    end
    
    class BoolField < Base
      def typed_default_value(default=nil)
        default or false
      end

      def acceptable?(val)
        raise TypeError unless [TrueClass, FalseClass].include? val.class
        true
      end
    end
    
    class Message < Base
      def wire_type
        Protobuf::WireType::LENGTH_DELIMITED
      end

      def typed_default_value(default=nil)
        if default.is_a? Symbol
          type.module_eval default.to_s
        else
          default
        end
      end

      def acceptable?(val)
        raise TypeError unless val.instance_of? type
        true
      end
 
      def set_bytes(method_instance, bytes)
        message = type.new
        #message.parse_from bytes
        message.parse_from_string bytes.to_string # TODO
        method_instance.send("#{name}=", message)
      end
 
      def set_array(method_instance, bytes)
        message = type.new
        #message.parse_from bytes
        message.parse_from_string bytes.to_string
        arr = method_instance.send name
        arr << message
      end

      def get_bytes(value)
        stringio = StringIO.new ''
        value.serialize_to stringio
        bytes = stringio.string.unpack 'C*'
        string_size = Int.get_bytes bytes.size
        string_size + bytes
        #bytes + string_size
      end
    end

    class Enum < Int
      def acceptable?(val)
        raise TypeError unless type.valid_tag? val
        true
      end
    end
  end
end
