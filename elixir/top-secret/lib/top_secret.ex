defmodule TopSecret do
  def to_ast(string) do
    case Code.string_to_quoted(string) do
      {:ok, ast} -> ast
      {:error, _} -> {:error, "Invalid AST"}
    end
  end

  def decode_secret_message_part({:def, _, [{name, _, args} | _]} = ast, acc) do
    # Extract the function name and arity
    {function_name, arity} =
      case name do
        :when ->
          # Extract the actual function name and arguments from the first element of the list following :when
          {actual_name, _, actual_args} = hd(args)
          {Atom.to_string(actual_name), length(actual_args || [])}

        _ ->
          {Atom.to_string(name), length(args || [])}
      end

    # Take the first `n` characters from the function name
    secret_part = String.slice(function_name, 0, arity)

    # Add the secret part to the accumulator
    {ast, [secret_part | acc]}
  end

  def decode_secret_message_part({:defp, _, [{name, _, args} | _]} = ast, acc) do
    # Extract the function name and arity
    {function_name, arity} =
      case name do
        :when ->
          # Extract the actual function name and arguments from the first element of the list following :when
          {actual_name, _, actual_args} = hd(args)
          {Atom.to_string(actual_name), length(actual_args || [])}

        _ ->
          {Atom.to_string(name), length(args || [])}
      end

    # Take the first `n` characters from the function name
    secret_part = String.slice(function_name, 0, arity)
    # Add the secret part to the accumulator
    {ast, [secret_part | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    # For all other cases, return the accumulator as is
    {ast, acc}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)

    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc |> Enum.reverse() |> Enum.join("")




  end
end
