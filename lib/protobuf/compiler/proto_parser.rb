#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.5
# from racc grammer file "lib/protobuf/compiler/proto.y".
#
#
# lib/protobuf/compiler/proto_parser.rb: generated by racc (runtime embedded)
#
###### racc/parser.rb begin
unless $".index 'racc/parser.rb'
$".push 'racc/parser.rb'

self.class.module_eval <<'..end racc/parser.rb modeval..id5d99c3dde7', 'racc/parser.rb', 1
#
# $Id: parser.rb,v 1.7 2005/11/20 17:31:32 aamine Exp $
#
# Copyright (c) 1999-2005 Minero Aoki
#
# This program is free software.
# You can distribute/modify this program under the same terms of ruby.
#
# As a special exception, when this code is copied by Racc
# into a Racc output file, you may use that output file
# without restriction.
#

unless defined?(NotImplementedError)
  NotImplementedError = NotImplementError
end

module Racc
  class ParseError < StandardError; end
end
unless defined?(::ParseError)
  ParseError = Racc::ParseError
end

module Racc

  unless defined?(Racc_No_Extentions)
    Racc_No_Extentions = false
  end

  class Parser

    Racc_Runtime_Version = '1.4.5'
    Racc_Runtime_Revision = '$Revision: 1.7 $'.split[1]

    Racc_Runtime_Core_Version_R = '1.4.5'
    Racc_Runtime_Core_Revision_R = '$Revision: 1.7 $'.split[1]
    begin
      require 'racc/cparse'
    # Racc_Runtime_Core_Version_C  = (defined in extention)
      Racc_Runtime_Core_Revision_C = Racc_Runtime_Core_Id_C.split[2]
      unless new.respond_to?(:_racc_do_parse_c, true)
        raise LoadError, 'old cparse.so'
      end
      if Racc_No_Extentions
        raise LoadError, 'selecting ruby version of racc runtime core'
      end

      Racc_Main_Parsing_Routine    = :_racc_do_parse_c
      Racc_YY_Parse_Method         = :_racc_yyparse_c
      Racc_Runtime_Core_Version    = Racc_Runtime_Core_Version_C
      Racc_Runtime_Core_Revision   = Racc_Runtime_Core_Revision_C
      Racc_Runtime_Type            = 'c'
    rescue LoadError
      Racc_Main_Parsing_Routine    = :_racc_do_parse_rb
      Racc_YY_Parse_Method         = :_racc_yyparse_rb
      Racc_Runtime_Core_Version    = Racc_Runtime_Core_Version_R
      Racc_Runtime_Core_Revision   = Racc_Runtime_Core_Revision_R
      Racc_Runtime_Type            = 'ruby'
    end

    def Parser.racc_runtime_type
      Racc_Runtime_Type
    end

    private

    def _racc_setup
      @yydebug = false unless self.class::Racc_debug_parser
      @yydebug = false unless defined?(@yydebug)
      if @yydebug
        @racc_debug_out = $stderr unless defined?(@racc_debug_out)
        @racc_debug_out ||= $stderr
      end
      arg = self.class::Racc_arg
      arg[13] = true if arg.size < 14
      arg
    end

    def _racc_init_sysvars
      @racc_state  = [0]
      @racc_tstack = []
      @racc_vstack = []

      @racc_t = nil
      @racc_val = nil

      @racc_read_next = true

      @racc_user_yyerror = false
      @racc_error_status = 0
    end

    ###
    ### do_parse
    ###

    def do_parse
      __send__(Racc_Main_Parsing_Routine, _racc_setup(), false)
    end

    def next_token
      raise NotImplementedError, "#{self.class}\#next_token is not defined"
    end

    def _racc_do_parse_rb(arg, in_debug)
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg

      _racc_init_sysvars
      tok = act = i = nil
      nerr = 0

      catch(:racc_end_parse) {
        while true
          if i = action_pointer[@racc_state[-1]]
            if @racc_read_next
              if @racc_t != 0   # not EOF
                tok, @racc_val = next_token()
                unless tok      # EOF
                  @racc_t = 0
                else
                  @racc_t = (token_table[tok] or 1)   # error token
                end
                racc_read_token(@racc_t, tok, @racc_val) if @yydebug
                @racc_read_next = false
              end
            end
            i += @racc_t
            unless i >= 0 and
                   act = action_table[i] and
                   action_check[i] == @racc_state[-1]
              act = action_default[@racc_state[-1]]
            end
          else
            act = action_default[@racc_state[-1]]
          end
          while act = _racc_evalact(act, arg)
            ;
          end
        end
      }
    end

    ###
    ### yyparse
    ###

    def yyparse(recv, mid)
      __send__(Racc_YY_Parse_Method, recv, mid, _racc_setup(), true)
    end

    def _racc_yyparse_rb(recv, mid, arg, c_debug)
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg

      _racc_init_sysvars
      tok = nil
      act = nil
      i = nil
      nerr = 0

      catch(:racc_end_parse) {
        until i = action_pointer[@racc_state[-1]]
          while act = _racc_evalact(action_default[@racc_state[-1]], arg)
            ;
          end
        end
        recv.__send__(mid) do |tok, val|
          unless tok
            @racc_t = 0
          else
            @racc_t = (token_table[tok] or 1)   # error token
          end
          @racc_val = val
          @racc_read_next = false

          i += @racc_t
          unless i >= 0 and
                 act = action_table[i] and
                 action_check[i] == @racc_state[-1]
            act = action_default[@racc_state[-1]]
          end
          while act = _racc_evalact(act, arg)
            ;
          end

          while not (i = action_pointer[@racc_state[-1]]) or
                not @racc_read_next or
                @racc_t == 0   # $
            unless i and i += @racc_t and
                   i >= 0 and
                   act = action_table[i] and
                   action_check[i] == @racc_state[-1]
              act = action_default[@racc_state[-1]]
            end
            while act = _racc_evalact(act, arg)
              ;
            end
          end
        end
      }
    end

    ###
    ### common
    ###

    def _racc_evalact(act, arg)
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg
      nerr = 0   # tmp

      if act > 0 and act < shift_n
        #
        # shift
        #
        if @racc_error_status > 0
          @racc_error_status -= 1 unless @racc_t == 1   # error token
        end
        @racc_vstack.push @racc_val
        @racc_state.push act
        @racc_read_next = true
        if @yydebug
          @racc_tstack.push @racc_t
          racc_shift @racc_t, @racc_tstack, @racc_vstack
        end

      elsif act < 0 and act > -reduce_n
        #
        # reduce
        #
        code = catch(:racc_jump) {
          @racc_state.push _racc_do_reduce(arg, act)
          false
        }
        if code
          case code
          when 1 # yyerror
            @racc_user_yyerror = true   # user_yyerror
            return -reduce_n
          when 2 # yyaccept
            return shift_n
          else
            raise '[Racc Bug] unknown jump code'
          end
        end

      elsif act == shift_n
        #
        # accept
        #
        racc_accept if @yydebug
        throw :racc_end_parse, @racc_vstack[0]

      elsif act == -reduce_n
        #
        # error
        #
        case @racc_error_status
        when 0
          unless arg[21]    # user_yyerror
            nerr += 1
            on_error @racc_t, @racc_val, @racc_vstack
          end
        when 3
          if @racc_t == 0   # is $
            throw :racc_end_parse, nil
          end
          @racc_read_next = true
        end
        @racc_user_yyerror = false
        @racc_error_status = 3
        while true
          if i = action_pointer[@racc_state[-1]]
            i += 1   # error token
            if  i >= 0 and
                (act = action_table[i]) and
                action_check[i] == @racc_state[-1]
              break
            end
          end
          throw :racc_end_parse, nil if @racc_state.size <= 1
          @racc_state.pop
          @racc_vstack.pop
          if @yydebug
            @racc_tstack.pop
            racc_e_pop @racc_state, @racc_tstack, @racc_vstack
          end
        end
        return act

      else
        raise "[Racc Bug] unknown action #{act.inspect}"
      end

      racc_next_state(@racc_state[-1], @racc_state) if @yydebug

      nil
    end

    def _racc_do_reduce(arg, act)
      action_table, action_check, action_default, action_pointer,
      goto_table,   goto_check,   goto_default,   goto_pointer,
      nt_base,      reduce_table, token_table,    shift_n,
      reduce_n,     use_result,   * = arg
      state = @racc_state
      vstack = @racc_vstack
      tstack = @racc_tstack

      i = act * -3
      len       = reduce_table[i]
      reduce_to = reduce_table[i+1]
      method_id = reduce_table[i+2]
      void_array = []

      tmp_t = tstack[-len, len] if @yydebug
      tmp_v = vstack[-len, len]
      tstack[-len, len] = void_array if @yydebug
      vstack[-len, len] = void_array
      state[-len, len]  = void_array

      # tstack must be updated AFTER method call
      if use_result
        vstack.push __send__(method_id, tmp_v, vstack, tmp_v[0])
      else
        vstack.push __send__(method_id, tmp_v, vstack)
      end
      tstack.push reduce_to

      racc_reduce(tmp_t, reduce_to, tstack, vstack) if @yydebug

      k1 = reduce_to - nt_base
      if i = goto_pointer[k1]
        i += state[-1]
        if i >= 0 and (curstate = goto_table[i]) and goto_check[i] == k1
          return curstate
        end
      end
      goto_default[k1]
    end

    def on_error(t, val, vstack)
      raise ParseError, sprintf("\nparse error on value %s (%s)",
                                val.inspect, token_to_str(t) || '?')
    end

    def yyerror
      throw :racc_jump, 1
    end

    def yyaccept
      throw :racc_jump, 2
    end

    def yyerrok
      @racc_error_status = 0
    end

    #
    # for debugging output
    #

    def racc_read_token(t, tok, val)
      @racc_debug_out.print 'read    '
      @racc_debug_out.print tok.inspect, '(', racc_token2str(t), ') '
      @racc_debug_out.puts val.inspect
      @racc_debug_out.puts
    end

    def racc_shift(tok, tstack, vstack)
      @racc_debug_out.puts "shift   #{racc_token2str tok}"
      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_reduce(toks, sim, tstack, vstack)
      out = @racc_debug_out
      out.print 'reduce '
      if toks.empty?
        out.print ' <none>'
      else
        toks.each {|t| out.print ' ', racc_token2str(t) }
      end
      out.puts " --> #{racc_token2str(sim)}"
          
      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_accept
      @racc_debug_out.puts 'accept'
      @racc_debug_out.puts
    end

    def racc_e_pop(state, tstack, vstack)
      @racc_debug_out.puts 'error recovering mode: pop token'
      racc_print_states state
      racc_print_stacks tstack, vstack
      @racc_debug_out.puts
    end

    def racc_next_state(curstate, state)
      @racc_debug_out.puts  "goto    #{curstate}"
      racc_print_states state
      @racc_debug_out.puts
    end

    def racc_print_stacks(t, v)
      out = @racc_debug_out
      out.print '        ['
      t.each_index do |i|
        out.print ' (', racc_token2str(t[i]), ' ', v[i].inspect, ')'
      end
      out.puts ' ]'
    end

    def racc_print_states(s)
      out = @racc_debug_out
      out.print '        ['
      s.each {|st| out.print ' ', st }
      out.puts ' ]'
    end

    def racc_token2str(tok)
      self.class::Racc_token_to_s_table[tok] or
          raise "[Racc Bug] can't convert token #{tok} to string"
    end

    def token_to_str(t)
      self.class::Racc_token_to_s_table[t]
    end

  end

end
..end racc/parser.rb modeval..id5d99c3dde7
end
###### racc/parser.rb end


module Protobuf

  class ProtoParser < Racc::Parser

module_eval <<'..end lib/protobuf/compiler/proto.y modeval..id45a3b588b4', 'lib/protobuf/compiler/proto.y', 162

  def parse(f)
    @q = []
    f.each do |line|
      until line.empty? do
        case line
        when /\A\s+/, /\A\/\/.*/
          ;
        when /\A(required|optional|repeated|import|package|option|message|extend|enum|service|rpc|returns|group|default|extensions|to|max|double|float|int32|int64|uint32|uint64|sint32|sint64|fixed32|fixed64|sfixed32|sfixed64|bool|string|bytes)\b/
          @q.push [$&, $&.to_sym]
        when /\A[1-9]\d*/, /\A0(?![.xX0-9])/
          @q.push [:DEC_INTEGER, $&.to_i]
        when /\A0[xX]([A-Fa-f0-9])+/
          @q.push [:HEX_INTEGER, $&.to_i(0)]
        when /\A0[0-7]+/
          @q.push [:OCT_INTEGER, $&.to_i(0)]
        when /\A\d+(\.\d+)?([Ee][\+-]?\d+)?/
          @q.push [:FLOAT_LITERAL, $&.to_f]
        when /\A(true|false)/
          @q.push [:BOOLEAN_LITERAL, $& == 'true']
        when /\A"(?:[^"\\]+|\\.)*"/, /\A'(?:[^'\\]+|\\.)*'/
          @q.push [:STRING_LITERAL, eval($&)]
        when /\A[a-zA-Z_][\w_]*/
          @q.push [:IDENT, $&.to_sym]
        when /\A[A-Z][\w_]*/
          @q.push [:CAMEL_IDENT, $&.to_sym]
        when /\A./
          @q.push [$&, $&]
        else
          raise ArgumentError.new(line) 
        end
        line = $'
      end
    end
    do_parse
  end

  def next_token
    @q.shift
  end
..end lib/protobuf/compiler/proto.y modeval..id45a3b588b4

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 1, 53, :_reduce_1,
 2, 53, :_reduce_2,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 1, 54, :_reduce_none,
 3, 58, :_reduce_11,
 4, 59, :_reduce_12,
 0, 62, :_reduce_13,
 3, 62, :_reduce_14,
 3, 60, :_reduce_15,
 4, 63, :_reduce_16,
 3, 55, :_reduce_17,
 5, 56, :_reduce_18,
 0, 67, :_reduce_19,
 2, 67, :_reduce_20,
 1, 68, :_reduce_none,
 1, 68, :_reduce_none,
 1, 68, :_reduce_none,
 5, 57, :_reduce_24,
 0, 71, :_reduce_25,
 2, 71, :_reduce_26,
 1, 72, :_reduce_none,
 1, 72, :_reduce_none,
 1, 72, :_reduce_none,
 4, 73, :_reduce_30,
 5, 61, :_reduce_31,
 0, 75, :_reduce_32,
 2, 75, :_reduce_33,
 1, 76, :_reduce_none,
 1, 76, :_reduce_none,
 1, 76, :_reduce_none,
 10, 77, :_reduce_37,
 0, 78, :_reduce_none,
 1, 78, :_reduce_none,
 3, 65, :_reduce_40,
 0, 79, :_reduce_41,
 2, 79, :_reduce_42,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 1, 80, :_reduce_none,
 6, 70, :_reduce_51,
 6, 69, :_reduce_52,
 9, 69, :_reduce_53,
 1, 84, :_reduce_54,
 3, 84, :_reduce_55,
 1, 85, :_reduce_none,
 3, 85, :_reduce_57,
 4, 81, :_reduce_58,
 0, 87, :_reduce_59,
 2, 87, :_reduce_60,
 1, 86, :_reduce_61,
 3, 86, :_reduce_62,
 3, 86, :_reduce_63,
 1, 82, :_reduce_none,
 1, 82, :_reduce_none,
 1, 82, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 1, 83, :_reduce_none,
 2, 66, :_reduce_83,
 3, 66, :_reduce_84,
 1, 64, :_reduce_none,
 1, 64, :_reduce_none,
 1, 64, :_reduce_none,
 1, 64, :_reduce_none,
 1, 64, :_reduce_none,
 1, 74, :_reduce_none,
 1, 74, :_reduce_none,
 1, 74, :_reduce_none ]

racc_reduce_n = 93

racc_shift_n = 151

racc_action_table = [
    74,   126,    77,    47,    43,    74,    83,    77,    43,    50,
    25,   134,    14,    25,    16,     1,    38,    85,     6,    43,
    52,    48,    75,    76,    78,    19,    20,    19,    20,   137,
    88,   133,   137,    56,    57,    58,    56,    57,    58,    19,
    20,   107,    35,    72,    73,    75,    76,    78,    72,    73,
    75,    76,    78,   109,    94,    96,    98,    99,   100,   101,
   102,   104,   105,   106,   108,    93,    95,    97,    27,    34,
     4,     7,   110,    11,    67,   111,    14,    33,    16,     1,
    14,   114,     6,     9,   115,    68,     4,     7,    69,    11,
    19,    20,    14,    32,    16,     1,    60,   117,     6,     9,
    63,   118,    14,    75,    76,    78,   119,    61,    75,    76,
    78,    75,    76,    78,    75,    76,    78,    75,    76,    78,
   143,   144,   121,   122,   123,    39,    30,    29,   129,    25,
    24,   132,    23,    40,   136,    22,   141,   142,    40,    43,
    21,   147,    59,   149,   150 ]

racc_action_check = [
    48,   118,    48,    36,    31,   142,    49,   142,    36,    42,
   133,   130,    49,   144,    49,    49,    26,    49,    49,    37,
    42,    37,   118,   118,   118,   117,   117,    55,    55,   133,
    49,   130,   144,    49,    49,    49,    42,    42,    42,     1,
     1,    55,    23,    48,    48,    48,    48,    48,   142,   142,
   142,   142,   142,    55,    55,    55,    55,    55,    55,    55,
    55,    55,    55,    55,    55,    55,    55,    55,    15,    22,
    15,    15,    63,    15,    46,    69,    15,    21,    15,    15,
    46,   103,    15,    15,   107,    46,     0,     0,    46,     0,
   141,   141,     0,    20,     0,     0,    45,   111,     0,     0,
    45,   112,    45,   121,   121,   121,   113,    45,   119,   119,
   119,    88,    88,    88,   110,   110,   110,   122,   122,   122,
   138,   138,   114,   115,   116,    27,    18,    16,   120,    14,
    11,   125,     9,   131,   132,     7,   136,   137,    29,    44,
     6,   143,    43,   145,   149 ]

racc_action_pointer = [
    84,    33,   nil,   nil,   nil,   nil,   134,   131,   nil,   126,
   nil,   124,   nil,   nil,   123,    68,   121,   nil,   114,   nil,
    87,    65,    67,    30,   nil,   nil,    14,   125,   nil,   126,
   nil,    -3,   nil,   nil,   nil,   nil,     1,    12,   nil,   nil,
   nil,   nil,     7,   136,   132,    94,    72,   nil,    -4,     4,
   nil,   nil,   nil,   nil,   nil,    21,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    63,   nil,   nil,   nil,   nil,   nil,    69,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    62,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    75,   nil,   nil,   nil,    63,   nil,   nil,
    65,    80,    74,    82,   113,   114,   122,    19,   -27,    59,
   126,    54,    68,   nil,   nil,   113,   nil,   nil,   nil,   nil,
     9,   121,   115,     4,   nil,   nil,   119,   128,    97,   nil,
   nil,    84,     1,   139,     7,   125,   nil,   nil,   nil,   142,
   nil ]

racc_action_default = [
   -93,   -93,    -3,    -4,   -10,    -5,   -93,   -93,    -6,   -93,
    -7,   -93,    -8,    -9,   -93,   -93,   -93,    -1,   -93,   -13,
   -93,   -93,   -93,   -93,   -13,   -13,   -93,   -93,    -2,   -93,
   -19,   -83,   -13,   -25,   -11,   -32,   -93,   -93,   -15,   151,
   -41,   -17,   -93,   -93,   -84,   -93,   -93,   -12,   -93,   -93,
   -23,   -20,   -18,   -21,   -22,   -93,   -64,   -65,   -66,   -14,
   -29,   -24,   -27,   -93,   -26,   -28,   -35,   -36,   -31,   -93,
   -34,   -33,   -87,   -89,   -88,   -90,   -91,   -85,   -92,   -86,
   -16,   -45,   -46,   -50,   -44,   -40,   -43,   -42,   -93,   -48,
   -47,   -49,   -82,   -79,   -68,   -80,   -69,   -81,   -70,   -71,
   -72,   -73,   -74,   -93,   -75,   -76,   -77,   -93,   -78,   -67,
   -93,   -93,   -61,   -59,   -93,   -93,   -93,   -38,   -93,   -93,
   -93,   -93,   -93,   -30,   -39,   -93,   -63,   -62,   -60,   -58,
   -93,   -93,   -93,   -93,   -52,   -51,   -93,   -93,   -93,   -56,
   -54,   -38,   -93,   -93,   -93,   -93,   -57,   -53,   -55,   -93,
   -37 ]

racc_goto_table = [
    41,    80,    18,   112,   113,   125,    17,    31,   140,    54,
    53,    45,    36,    37,    62,    70,    89,    86,    91,   148,
    44,    28,    42,    26,    51,   116,    64,    65,    84,   145,
    46,    71,    66,   127,   112,   128,   130,   131,    82,    49,
    87,    90,   103,   138,    81,    15,   120,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    92,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   146,   nil,   nil,   nil,   nil,
   nil,   nil,   135 ]

racc_goto_check = [
    13,    12,    14,    22,    34,    26,     2,    10,    33,    18,
    17,    19,    10,    10,     8,     8,    18,    17,     8,    33,
    10,     2,    15,    11,    16,    22,    20,    21,     5,    26,
    23,    24,    25,    22,    22,    34,    22,    22,     4,    27,
    28,    29,    31,    32,     3,     1,    35,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    14,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    12,   nil,   nil,   nil,   nil,
   nil,   nil,    13 ]

racc_goto_pointer = [
   nil,    45,     6,    -5,   -11,   -21,   nil,   nil,   -31,   nil,
   -12,     9,   -47,   -29,     1,    -8,   -18,   -32,   -33,   -22,
   -19,   -18,   -85,    -5,   -15,   -14,  -112,    -1,    -9,    -8,
   nil,   -13,   -90,  -125,   -84,   -67 ]

racc_goto_default = [
   nil,   nil,   nil,     2,     3,     5,     8,    10,    12,    13,
   nil,   139,   nil,   nil,   124,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    79,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    55,   nil,   nil,   nil,   nil,   nil ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 ";" => 2,
 "import" => 3,
 :STRING_LITERAL => 4,
 "package" => 5,
 :IDENT => 6,
 "." => 7,
 "option" => 8,
 "=" => 9,
 "message" => 10,
 "extend" => 11,
 "{" => 12,
 "}" => 13,
 "enum" => 14,
 "service" => 15,
 "rpc" => 16,
 "(" => 17,
 ")" => 18,
 "returns" => 19,
 "group" => 20,
 :CAMEL_IDENT => 21,
 "[" => 22,
 "]" => 23,
 "," => 24,
 "default" => 25,
 "extensions" => 26,
 "to" => 27,
 "max" => 28,
 "required" => 29,
 "optional" => 30,
 "repeated" => 31,
 "double" => 32,
 "float" => 33,
 "int32" => 34,
 "int64" => 35,
 "uint32" => 36,
 "uint64" => 37,
 "sint32" => 38,
 "sint64" => 39,
 "fixed32" => 40,
 "fixed64" => 41,
 "sfixed32" => 42,
 "sfixed64" => 43,
 "bool" => 44,
 "string" => 45,
 "bytes" => 46,
 :FLOAT_LITERAL => 47,
 :BOOLEAN_LITERAL => 48,
 :DEC_INTEGER => 49,
 :HEX_INTEGER => 50,
 :OCT_INTEGER => 51 }

racc_use_result_var = true

racc_nt_base = 52

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'";"',
'"import"',
'STRING_LITERAL',
'"package"',
'IDENT',
'"."',
'"option"',
'"="',
'"message"',
'"extend"',
'"{"',
'"}"',
'"enum"',
'"service"',
'"rpc"',
'"("',
'")"',
'"returns"',
'"group"',
'CAMEL_IDENT',
'"["',
'"]"',
'","',
'"default"',
'"extensions"',
'"to"',
'"max"',
'"required"',
'"optional"',
'"repeated"',
'"double"',
'"float"',
'"int32"',
'"int64"',
'"uint32"',
'"uint64"',
'"sint32"',
'"sint64"',
'"fixed32"',
'"fixed64"',
'"sfixed32"',
'"sfixed64"',
'"bool"',
'"string"',
'"bytes"',
'FLOAT_LITERAL',
'BOOLEAN_LITERAL',
'DEC_INTEGER',
'HEX_INTEGER',
'OCT_INTEGER',
'$start',
'proto',
'proto_item',
'message',
'extend',
'enum',
'import',
'package',
'option',
'service',
'dot_ident_list',
'option_body',
'constant',
'message_body',
'user_type',
'extend_body_list',
'extend_body',
'field',
'group',
'enum_body_list',
'enum_body',
'enum_field',
'integer_literal',
'service_body_list',
'service_body',
'rpc',
'rpc_arg',
'message_body_body_list',
'message_body_body',
'extensions',
'label',
'type',
'field_option_list',
'field_option',
'extension',
'comma_extension_list']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 4
  def _reduce_1( val, _values, result )
 result = Protobuf::Node::ProtoNode.new val
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 6
  def _reduce_2( val, _values, result )
 result.children << val[1]
   result
  end
.,.,

 # reduce 3 omitted

 # reduce 4 omitted

 # reduce 5 omitted

 # reduce 6 omitted

 # reduce 7 omitted

 # reduce 8 omitted

 # reduce 9 omitted

 # reduce 10 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 19
  def _reduce_11( val, _values, result )
 result = Protobuf::Node::ImportNode.new val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 22
  def _reduce_12( val, _values, result )
 result = Protobuf::Node::PackageNode.new val[2].unshift(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 25
  def _reduce_13( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 27
  def _reduce_14( val, _values, result )
 result << val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 30
  def _reduce_15( val, _values, result )
 result = Protobuf::Node::OptionNode.new(*val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 33
  def _reduce_16( val, _values, result )
 result = [val[1].unshift(val[0]), val[3]]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 36
  def _reduce_17( val, _values, result )
 result = Protobuf::Node::MessageNode.new val[1], val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 39
  def _reduce_18( val, _values, result )
 result = Protobuf::Node::ExtendNode.new val[1], val[3]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 42
  def _reduce_19( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 44
  def _reduce_20( val, _values, result )
 result << val[1]
   result
  end
.,.,

 # reduce 21 omitted

 # reduce 22 omitted

 # reduce 23 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 52
  def _reduce_24( val, _values, result )
 result = Protobuf::Node::EnumNode.new val[1], val[3]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 55
  def _reduce_25( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 57
  def _reduce_26( val, _values, result )
 result << val[1]
   result
  end
.,.,

 # reduce 27 omitted

 # reduce 28 omitted

 # reduce 29 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 65
  def _reduce_30( val, _values, result )
 result = Protobuf::Node::EnumFieldNode.new val[0], val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 68
  def _reduce_31( val, _values, result )
 result = Protobuf::Node::ServiceNode.new val[1], val[3]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 71
  def _reduce_32( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 73
  def _reduce_33( val, _values, result )
 result << val[1]
   result
  end
.,.,

 # reduce 34 omitted

 # reduce 35 omitted

 # reduce 36 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 81
  def _reduce_37( val, _values, result )
 result = Protobuf::Node::RpcNode.new val[1], val[3], val[7]
   result
  end
.,.,

 # reduce 38 omitted

 # reduce 39 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 87
  def _reduce_40( val, _values, result )
 result = val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 90
  def _reduce_41( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 92
  def _reduce_42( val, _values, result )
 result << val[1]
   result
  end
.,.,

 # reduce 43 omitted

 # reduce 44 omitted

 # reduce 45 omitted

 # reduce 46 omitted

 # reduce 47 omitted

 # reduce 48 omitted

 # reduce 49 omitted

 # reduce 50 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 105
  def _reduce_51( val, _values, result )
 result = Protobuf::Node::GroupNode.new val[0], val[2], val[4], val[5]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 108
  def _reduce_52( val, _values, result )
 result = Protobuf::Node::FieldNode.new val[0], val[1], val[2], val[4]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 110
  def _reduce_53( val, _values, result )
 result = Protobuf::Node::FieldNode.new val[0], val[1], val[2], val[4], val[6]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 113
  def _reduce_54( val, _values, result )
 result = val
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 115
  def _reduce_55( val, _values, result )
 result << val[2]
   result
  end
.,.,

 # reduce 56 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 119
  def _reduce_57( val, _values, result )
 result = [:default, val[2]]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 122
  def _reduce_58( val, _values, result )
 result = Protobuf::Node::ExtensionsNode.new val[2].unshift(val[1])
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 125
  def _reduce_59( val, _values, result )
 result = []
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 127
  def _reduce_60( val, _values, result )
 result << val[1]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 130
  def _reduce_61( val, _values, result )
 result = Protobuf::Node::ExtensionRangeNode.new val[0]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 132
  def _reduce_62( val, _values, result )
 result = Protobuf::Node::ExtensionRangeNode.new val[0], val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 134
  def _reduce_63( val, _values, result )
 result = Protobuf::Node::ExtensionRangeNode.new val[0], :max
   result
  end
.,.,

 # reduce 64 omitted

 # reduce 65 omitted

 # reduce 66 omitted

 # reduce 67 omitted

 # reduce 68 omitted

 # reduce 69 omitted

 # reduce 70 omitted

 # reduce 71 omitted

 # reduce 72 omitted

 # reduce 73 omitted

 # reduce 74 omitted

 # reduce 75 omitted

 # reduce 76 omitted

 # reduce 77 omitted

 # reduce 78 omitted

 # reduce 79 omitted

 # reduce 80 omitted

 # reduce 81 omitted

 # reduce 82 omitted

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 145
  def _reduce_83( val, _values, result )
 result = val[1].unshift(val[0])
   result
  end
.,.,

module_eval <<'.,.,', 'lib/protobuf/compiler/proto.y', 147
  def _reduce_84( val, _values, result )
 result = val[1].unshift(val[0])
   result
  end
.,.,

 # reduce 85 omitted

 # reduce 86 omitted

 # reduce 87 omitted

 # reduce 88 omitted

 # reduce 89 omitted

 # reduce 90 omitted

 # reduce 91 omitted

 # reduce 92 omitted

 def _reduce_none( val, _values, result )
  result
 end

  end   # class ProtoParser

end   # module Protobuf
