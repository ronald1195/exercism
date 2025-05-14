defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    build_transmit_sequence(message, <<>>)
  end

  defp build_transmit_sequence(<<>>, acc), do: acc

  defp build_transmit_sequence(message, acc) when bit_size(message) < 7 do
    # Add trailing zeroes
    padded = add_reminding_bits(message)
    parity_bit = get_parity_bit(padded)
    acc <> <<padded::bitstring, parity_bit::bitstring>>
  end

  defp build_transmit_sequence(<<seven_bits::bitstring-size(7), rest::bitstring>>, acc) do
    parity_bit = get_parity_bit(seven_bits)
    byte_with_parity = <<seven_bits::bitstring, parity_bit::bitstring>>
    build_transmit_sequence(rest, <<acc::bitstring, byte_with_parity::bitstring>>)
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary(), binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(data, acc \\ <<>>)

  # End of transmission
  def decode_message(<<>>, acc) do
    truncated = truncate_to_byte(acc)
    {:ok, truncated}
  end

  # Handle final partial byte (< 8 bits)
  def decode_message(bits, acc) when bit_size(bits) < 8 do
    padded = add_reminding_bits(bits)
    parity_bit = get_parity_bit(padded)
    <<final_byte::bitstring>> = <<padded::bitstring, parity_bit::bitstring>>
    decode_message(<<>>, <<acc::bitstring, final_byte::bitstring>>)
  end

  # Handle full 8-bit bytes
  def decode_message(
        <<seven::bitstring-size(7), parity::bitstring-size(1), rest::bitstring>>,
        acc
      ) do
    expected_parity = get_parity_bit(seven)

    if parity == expected_parity do
      decode_message(rest, <<acc::bitstring, seven::bitstring>>)
    else
      {:error, "wrong parity"}
    end
  end

  @spec count_one_bits(<<_::7>>) :: integer()
  def count_one_bits(<<bit1::1, bit2::1, bit3::1, bit4::1, bit5::1, bit6::1, bit7::1>>) do
    [bit1, bit2, bit3, bit4, bit5, bit6, bit7]
    |> Enum.count(&(&1 == 1))
  end

  @spec get_parity_bit(<<_::7>>) :: <<_::1>>
  def get_parity_bit(bitstring) do
    if rem(count_one_bits(bitstring), 2) == 0 do
      <<0::1>>
    else
      <<1::1>>
    end
  end

  def add_reminding_bits(bitstring) do
    missing_bits = 7 - bit_size(bitstring)

    if missing_bits > 0 do
      <<bitstring::bitstring, 0::size(missing_bits)>>
    else
      bitstring
    end
  end

  defp truncate_to_byte(bits) do
    total_bits = bit_size(bits)
    full_bytes = div(total_bits, 8)
    byte_bits = full_bytes * 8

    <<result::bitstring-size(byte_bits), _::bitstring>> = bits
    result
  end
end
