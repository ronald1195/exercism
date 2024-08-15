defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    # Please implement the get_combinations/3 function
    for top <- tops, bottom <- bottoms, top[:base_color] != bottom[:base_color] and top[:price] + bottom[:price] < options[:maximum_price] do
      {top, bottom}
    end
  end
end
