defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  # partial
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &is_anagram?(base, &1))
  end

  defp is_anagram?(base, candidate) do
    base != candidate &&
      sorted_string(base) ==
        sorted_string(candidate)
  end

  defp sorted_string(string) do
    Enum.sort(String.downcase(string) |> String.graphemes())
  end
end
