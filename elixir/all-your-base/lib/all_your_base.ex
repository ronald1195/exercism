defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    # if input_base < 2 || output_base < 2 do
    #   {:error, "Bases must be at least 2"}
    # else
    #   case digits do
    #     [] -> {:ok, []}
    #     _ -> convert(digits, input_base, output_base, 0, 0)
    #   end
    # end
    # partial
    # partial 2
    # last partial
    # nvm this is the last
  end
end
