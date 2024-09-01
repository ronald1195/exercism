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
    actions = [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ]

    handshake =
      Enum.reduce(actions, [], fn {bit, action}, acc ->
        if code &&& bit != 0 do
          [action | acc]
        else
          acc
        end
      end)

    if code &&& 16 != 0 do
      Enum.reverse(handshake)
    else
      handshake
    end
  end
end
