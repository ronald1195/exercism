defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    {:ok, decoded_message} = decode_message(message)
    decoded_message
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary(), binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data, decoded_message \\ <<>>)

  def decode_message(<<>>, decoded_message) do
    {:ok, decoded_message}
  end

  def decode_message(received_data, decoded_message) when bit_size(received_data) < 7 do
    # IO.inspect("")
    # IO.inspect("unfinished byte detected")
    # IO.inspect(received_data, label: "Received data")
    # IO.inspect(decoded_message, label: "Decoded message")
  #   # IO.inspect(bit_size(received_data), label: "Byte size of received data")

    full_last_seven_bits = add_reminding_bits(received_data)
    parity_bit = get_parity_bit(full_last_seven_bits)
    last_byte = <<full_last_seven_bits::bitstring, parity_bit::bitstring>>

    decode_message(<<>>, << decoded_message::bitstring, last_byte::bitstring >>)
  end

  def decode_message(<< <<head::bitstring-size(7), carrying::bitstring-size(1) >>, rest::binary>>, decoded_message) do
    parity_bit = get_parity_bit(head)
    new_byte = <<head::bitstring, parity_bit::bitstring>>

    decode_message(<<carrying::bitstring, rest::binary>>, <<decoded_message::bitstring, new_byte::bitstring>>)
  end

  @spec count_one_bits(<<_::7>>) :: integer()
  def count_one_bits(<<bit1::1, bit2::1, bit3::1, bit4::1, bit5::1, bit6::1, bit7::1>>) do
    [bit1, bit2, bit3, bit4, bit5, bit6, bit7]
    |> Enum.count(&(&1 == 1))
  end

  @spec get_parity_bit(<<_::7>>) :: <<_::1>>
  def get_parity_bit(bitstring) do
    # IO.inspect(bitstring, label: "Bitstring")
    if rem(count_one_bits(bitstring), 2) == 0 do
      <<0::1>>
    else
      <<1::1>>
    end
  end

  def add_reminding_bits(bitstring) do
    missing_bits = 7 - bit_size(bitstring)
    # IO.inspect(missing_bits, label: "Missing bits")
    # IO.inspect(bit_size(bitstring), label: "bit size")

    if missing_bits > 0 do
      <<bitstring::bitstring, 0::size(missing_bits)>>
    else
      bitstring
    end
  end
end
