defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number
    |> number_of_digits()
    |> sum_power(number)
    |> Kernel.==(number)
  end

  defp number_of_digits(number) do
    number
    |> Integer.to_string()
    |> String.length()
  end

  defp sum_power(power, number) do
    number
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn x -> x ** power end)
    |> Enum.sum()
  end
end
