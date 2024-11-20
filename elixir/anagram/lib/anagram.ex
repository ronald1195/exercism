defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(base, &1))
  end

  defp anagram?(base, candidate) do
    String.downcase(base) != String.downcase(candidate) &&
      sorted_string(base) ==
        sorted_string(candidate)
  end

  defp sorted_string(string) do
    Enum.sort(String.downcase(string) |> String.graphemes())
  end
end
