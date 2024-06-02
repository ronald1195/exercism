defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    diff = List.myers_difference(a, b)

    case diff do
      [] ->
        :equal

      _ ->
        {additions, deletions} = Enum.reduce(diff, {0, 0}, fn
          {:add, _}, {adds, dels} -> {adds + 1, dels}
          {:delete, _}, {adds, dels} -> {adds, dels + 1}
        end)

        cond do
          additions == 0 -> :sublist
          deletions == 0 -> :superlist
          true -> :unequal
        end
    end
  end
end
