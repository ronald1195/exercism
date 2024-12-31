defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    # Roman numerals: I, V, X, L, C, D, M
    roman_numerals = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]

    # convert number to roman numeral by iterating over the roman_numerals list and substracting the value from the number by which the numner is dividible and adding the roman numeral to the result
    Enum.reduce(roman_numerals, {number, ""}, fn {divisor, roman}, {num, result} ->
      {rem(num, divisor), result <> String.duplicate(roman, div(num, divisor))}
    end)
    |> elem(1)
  end
end
