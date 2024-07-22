defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    case {input_base, output_base} do
      {_, _} when input_base < 2 -> {:error, "input base must be >= 2"}
      {_, _} when output_base < 2 -> {:error, "output base must be >= 2"}
      _ -> convert(digits, input_base, output_base, [])
    end
  end

  defp convert([], _, _, acc) do
    {:ok, acc}
  end

end # another easy day
# doing hackerrranks stuff
