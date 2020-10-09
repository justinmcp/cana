# Generated from lib/cana/validator.ex.exs, do not edit.
# Generated at 2020-10-09 06:40:09Z.

defmodule Cana.Validator do
  @doc """
  Parses the given `binary` as validate_email_address.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the validate_email_address (start position) as `{line, column_on_line}`.

  ## Options

    * `:line` - the initial line, defaults to 1
    * `:byte_offset` - the initial byte offset, defaults to 0
    * `:context` - the initial context value. It will be converted
      to a map

  """
  @spec validate_email_address(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map()
  def validate_email_address(binary, opts \\ []) when is_binary(binary) do
    line = Keyword.get(opts, :line, 1)
    offset = Keyword.get(opts, :byte_offset, 0)
    context = Map.new(Keyword.get(opts, :context, []))

    case(validate_email_address__0(binary, [], [], context, {line, offset}, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp validate_email_address__0(rest, acc, stack, context, line, offset) do
    validate_email_address__36(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp validate_email_address__2(rest, acc, stack, context, line, offset) do
    validate_email_address__3(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__3(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 !== 46 do
    validate_email_address__4(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__3(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected utf8 codepoint equal to '\"', followed by utf8 codepoint in the range 'a' to 'z' or in the range 'A' to 'Z' or in the range '0' to '9' or equal to ' ' or equal to '!' or in the range '#' to '/' or equal to '=' or equal to '?' or equal to '^' or equal to '_' or equal to '`' or equal to '{' or equal to '|' or equal to '}' or equal to '~' or equal to '@', followed by utf8 codepoint in the range 'a' to 'z' or in the range 'A' to 'Z' or in the range '0' to '9' or equal to ' ' or equal to '!' or in the range '#' to '/' or equal to '=' or equal to '?' or equal to '^' or equal to '_' or equal to '`' or equal to '{' or equal to '|' or equal to '}' or equal to '~' or equal to '@', followed by utf8 codepoint equal to '\"' or utf8 codepoint, and not equal to '.', followed by string \"..\", followed by string \".@\", followed by utf8 codepoint in the range 'a' to 'z' or in the range 'A' to 'Z' or in the range '0' to '9' or equal to '!' or in the range '#' to '-' or equal to '/' or equal to '=' or equal to '?' or equal to '^' or equal to '_' or equal to '`' or equal to '{' or equal to '|' or equal to '}' or equal to '~', followed by utf8 codepoint in the range 'a' to 'z' or in the range 'A' to 'Z' or in the range '0' to '9' or equal to '!' or in the range '#' to '-' or equal to '/' or equal to '=' or equal to '?' or equal to '^' or equal to '_' or equal to '`' or equal to '{' or equal to '|' or equal to '}' or equal to '~' or string \".\" or string \"\\\\\\\"\" or string \"\\\\ \" or string \"\\\\\\\\\" or string \"\\\\@\"",
     rest, context, line, offset}
  end

  defp validate_email_address__4(rest, acc, stack, context, line, offset) do
    validate_email_address__6(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp validate_email_address__6(<<"..", _::binary>> = rest, acc, stack, context, line, offset) do
    validate_email_address__5(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__6(rest, acc, stack, context, line, offset) do
    validate_email_address__7(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__7(<<".@", _::binary>> = rest, acc, stack, context, line, offset) do
    validate_email_address__5(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__7(rest, acc, stack, context, line, offset) do
    validate_email_address__8(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__8(rest, acc, stack, context, line, offset) do
    validate_email_address__25(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp validate_email_address__10(
         <<"\\@", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__11(rest, ["@"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp validate_email_address__10(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    validate_email_address__5(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__11(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__12(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__10(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__13(
         <<"\\\\", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__14(rest, ["\\"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp validate_email_address__13(rest, acc, stack, context, line, offset) do
    validate_email_address__12(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__15(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__13(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__16(
         <<"\\ ", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__17(rest, [" "] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp validate_email_address__16(rest, acc, stack, context, line, offset) do
    validate_email_address__15(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__17(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__18(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__16(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__19(
         <<"\\\"", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__20(rest, ["\""] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp validate_email_address__19(rest, acc, stack, context, line, offset) do
    validate_email_address__18(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__20(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__21(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__19(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__22(
         <<".", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__23(rest, ["."] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__22(rest, acc, stack, context, line, offset) do
    validate_email_address__21(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__23(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__24(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__22(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__25(rest, acc, stack, context, line, offset) do
    validate_email_address__26(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__26(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 33 or (x0 >= 35 and x0 <= 45) or x0 === 47 or x0 === 61 or x0 === 63 or
              x0 === 94 or x0 === 95 or x0 === 96 or x0 === 123 or x0 === 124 or x0 === 125 or
              x0 === 126 do
    validate_email_address__27(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__26(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__24(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__27(rest, acc, stack, context, line, offset) do
    validate_email_address__29(rest, acc, [63 | stack], context, line, offset)
  end

  defp validate_email_address__29(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 33 or (x0 >= 35 and x0 <= 45) or x0 === 47 or x0 === 61 or x0 === 63 or
              x0 === 94 or x0 === 95 or x0 === 96 or x0 === 123 or x0 === 124 or x0 === 125 or
              x0 === 126 do
    validate_email_address__30(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__29(rest, acc, stack, context, line, offset) do
    validate_email_address__28(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__28(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__31(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__30(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__31(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__30(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__29(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__31(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__32(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__32(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__9(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__5(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    validate_email_address__33(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__9(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    validate_email_address__6(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp validate_email_address__33(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__34(
      rest,
      [Enum.join(:lists.reverse(user_acc), "")] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__34(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__35(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__2(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__36(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 34 do
    validate_email_address__37(
      rest,
      [] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__36(rest, acc, stack, context, line, offset) do
    validate_email_address__35(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__37(rest, acc, stack, context, line, offset) do
    validate_email_address__38(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__38(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 32 or x0 === 33 or (x0 >= 35 and x0 <= 47) or x0 === 61 or x0 === 63 or
              x0 === 94 or x0 === 95 or x0 === 96 or x0 === 123 or x0 === 124 or x0 === 125 or
              x0 === 126 or x0 === 64 do
    validate_email_address__39(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__38(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__35(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__39(rest, acc, stack, context, line, offset) do
    validate_email_address__41(rest, acc, [63 | stack], context, line, offset)
  end

  defp validate_email_address__41(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 32 or x0 === 33 or (x0 >= 35 and x0 <= 47) or x0 === 61 or x0 === 63 or
              x0 === 94 or x0 === 95 or x0 === 96 or x0 === 123 or x0 === 124 or x0 === 125 or
              x0 === 126 or x0 === 64 do
    validate_email_address__42(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__41(rest, acc, stack, context, line, offset) do
    validate_email_address__40(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__40(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__43(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__42(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__43(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__42(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__41(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__43(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__44(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__44(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 34 do
    validate_email_address__45(
      rest,
      [] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__44(rest, acc, stack, context, line, offset) do
    validate_email_address__35(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__45(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__1(
         <<"@", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__46(rest, ["@"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"@\"", rest, context, line, offset}
  end

  defp validate_email_address__46(rest, acc, stack, context, line, offset) do
    validate_email_address__60(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp validate_email_address__48(rest, acc, stack, context, line, offset) do
    validate_email_address__50(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp validate_email_address__50(<<"-", _::binary>> = rest, acc, stack, context, line, offset) do
    validate_email_address__49(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__50(rest, acc, stack, context, line, offset) do
    validate_email_address__51(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__51(rest, acc, stack, context, line, offset) do
    validate_email_address__52(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__52(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 45 do
    validate_email_address__53(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__52(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__49(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__53(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 97 and x0 <= 122) or (x0 >= 65 and x0 <= 90) or (x0 >= 48 and x0 <= 57) or
              x0 === 45 do
    validate_email_address__55(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__53(rest, acc, stack, context, line, offset) do
    validate_email_address__54(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__55(rest, acc, stack, context, line, offset) do
    validate_email_address__53(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__54(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__56(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__56(
         <<".", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__57(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__56(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    validate_email_address__57(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp validate_email_address__49(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    validate_email_address__58(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__57(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    validate_email_address__50(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp validate_email_address__58(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__47(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__59(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    validate_email_address__48(rest, [], stack, context, line, offset)
  end

  defp validate_email_address__60(rest, acc, stack, context, line, offset) do
    validate_email_address__61(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__61(
         <<"[", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__62(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__61(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    validate_email_address__62(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp validate_email_address__62(rest, acc, stack, context, line, offset) do
    validate_email_address__63(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__63(rest, acc, stack, context, line, offset) do
    validate_email_address__65(rest, acc, [3 | stack], context, line, offset)
  end

  defp validate_email_address__65(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    validate_email_address__66(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__65(rest, acc, stack, context, line, offset) do
    validate_email_address__64(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__64(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__67(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__66(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__67(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__66(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__65(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__67(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__68(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__68(
         <<".", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__69(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__68(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__59(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__69(rest, acc, stack, context, line, offset) do
    validate_email_address__70(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__70(rest, acc, stack, context, line, offset) do
    validate_email_address__72(rest, acc, [3 | stack], context, line, offset)
  end

  defp validate_email_address__72(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    validate_email_address__73(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__72(rest, acc, stack, context, line, offset) do
    validate_email_address__71(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__71(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__74(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__73(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__74(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__73(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__72(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__74(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__75(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__75(
         <<".", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__76(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__75(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__59(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__76(rest, acc, stack, context, line, offset) do
    validate_email_address__77(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__77(rest, acc, stack, context, line, offset) do
    validate_email_address__79(rest, acc, [3 | stack], context, line, offset)
  end

  defp validate_email_address__79(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    validate_email_address__80(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__79(rest, acc, stack, context, line, offset) do
    validate_email_address__78(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__78(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__81(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__80(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__81(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__80(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__79(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__81(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__82(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__82(
         <<".", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__83(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__82(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    validate_email_address__59(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__83(rest, acc, stack, context, line, offset) do
    validate_email_address__84(rest, [], [acc | stack], context, line, offset)
  end

  defp validate_email_address__84(rest, acc, stack, context, line, offset) do
    validate_email_address__86(rest, acc, [3 | stack], context, line, offset)
  end

  defp validate_email_address__86(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    validate_email_address__87(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp validate_email_address__86(rest, acc, stack, context, line, offset) do
    validate_email_address__85(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__85(rest, acc, [_ | stack], context, line, offset) do
    validate_email_address__88(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__87(rest, acc, [1 | stack], context, line, offset) do
    validate_email_address__88(rest, acc, stack, context, line, offset)
  end

  defp validate_email_address__87(rest, acc, [count | stack], context, line, offset) do
    validate_email_address__86(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp validate_email_address__88(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__89(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__89(
         <<"]", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    validate_email_address__90(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp validate_email_address__89(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    validate_email_address__90(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp validate_email_address__90(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    validate_email_address__91(
      rest,
      [Enum.join(:lists.reverse(user_acc), ".")] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp validate_email_address__91(rest, acc, [_, previous_acc | stack], context, line, offset) do
    validate_email_address__47(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp validate_email_address__47(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end
end
