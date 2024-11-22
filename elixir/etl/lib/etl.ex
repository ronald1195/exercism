defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.flat_map(input, fn {score, letters} ->
      Enum.map(letters, fn letter -> {String.downcase(letter), score} end)
    end)
    |> Map.new()
  end
end
