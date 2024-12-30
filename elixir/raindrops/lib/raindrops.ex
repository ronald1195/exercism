defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    factors = Enum.filter(1..number, fn n -> rem(number, n) == 0 end)

    sounds =
      factors
      |> Enum.map(
        &case &1 do
          3 -> "Pling"
          5 -> "Plang"
          7 -> "Plong"
          _ -> ""
        end
      )
      |> Enum.join()

    if sounds == "" do
      Integer.to_string(number)
    else
      sounds
    end
  end
end
