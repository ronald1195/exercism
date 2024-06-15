defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @color_code %{:black => 0, :brown => 1, :red => 2, :orange => 3, :yellow => 4, :green => 5, :blue => 6, 
                :violet => 7, :grey => 8, :white => 9}
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([first, second, third]) do
    {(10 * @color_code[first] + @color_code[second]), :ohms}
  end
end
