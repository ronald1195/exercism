defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) when message != "" do
    # Analyze how many 1's are in the message

    number_of_ones =
      message
      |> :binary.bin_to_list()

    IO.inspect(number_of_ones, label: "Number of 1's in the message")
  end

  def get_transmit_sequence(message) do
    message
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
  end
end
