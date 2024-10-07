defmodule Allergies do
  @allergens %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats"
  }
  # partial
  # partial
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list([flags]) do
    Enum.filter(flags, fn flag -> @allergens[flag] end)
  end

  def list(flag) do
    case @allergens[flag] do
      nil -> []
      allergen -> [allergen]
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
  end
end
