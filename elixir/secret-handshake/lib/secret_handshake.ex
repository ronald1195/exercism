defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  import Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # dbg(code)

    actions = [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ]

    # dbg(actions)

    # if (16 &&& code) != 0 do
    #  actions = Enum.reverse(actions)
    # end

    # dbg(actions)

    Enum.reduce(actions, [], fn {bit, action}, acc ->
      if (bit &&& code) != 0 do
        acc ++ [action]
      else
        acc
      end
    end)
    |> reverse_if_needed(code)
  end

  defp reverse_if_needed(actions, code) do
    if (16 &&& code) != 0 do
      Enum.reverse(actions)
    else
      actions
    end
  end
end
