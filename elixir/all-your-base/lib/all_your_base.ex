defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    with :ok <- validate_bases(input_base, output_base),
         :ok <- validate_digits(digits) do
      do_convert(digits, input_base, output_base)
    end
  end

  defp do_convert(digits, input_base, output_base) do
    if Enum.any?(digits, fn digit -> digit < 0 or digit >= input_base end) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      digits
      |> to_decimal(input_base)
      |> from_decimal(output_base)
      |> case do
        [] -> {:ok, [0]}
        acc -> {:ok, Enum.reverse(acc)}
      end
    end
  end

  defp to_decimal(digits, base) do
    Enum.reduce(digits, 0, fn digit, acc -> acc * base + digit end)
  end

  defp from_decimal(0, _), do: []

  defp from_decimal(decimal, base) do
    [rem(decimal, base) | from_decimal(div(decimal, base), base)]
  end

  defp validate_bases(input_base, output_base) do
    cond do
      input_base < 2 -> {:error, "input base must be >= 2"}
      output_base < 2 -> {:error, "output base must be >= 2"}
      true -> :ok
    end
  end

  defp validate_digits(digits) do
    if Enum.any?(digits, &(&1 < 0)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      :ok
    end
  end
end
