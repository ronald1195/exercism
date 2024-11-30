defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    case length(strand1) == length(strand2) do
      false -> {:error, "Strands must be of the same length"}
      true -> {:ok, Enum.count(Enum.zip(strand1, strand2), fn {a, b} -> a != b end)}
    end
  end
end
