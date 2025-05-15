defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.map(&encode_integer/1)
    |> Enum.join()
  end

  defp encode_integer(integer) do
    variable_list =
      Integer.to_charlist(integer, 2)
      |> Enum.reverse()
      |> Enum.chunk_every(7)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.reverse()

    variable_list_length = length(variable_list)

    pad_zero_or_one = fn {index, el} ->
      el
      |> to_string
      |> String.pad_leading(
        8,
        "#{if index == variable_list_length - 1, do: "0", else: "1"}000000"
      )
    end

    var_length_number =
      variable_list
      |> Enum.with_index(&{&2, &1})
      |> Enum.map(pad_zero_or_one)
      |> Enum.join()
      |> to_charlist()
      |> List.to_integer(2)

    var_number_bytes =
      (variable_list_length * 8)
      |> trunc()

    <<var_length_number::size(var_number_bytes)>>
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
  end
end
