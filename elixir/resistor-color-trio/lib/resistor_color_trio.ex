defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @color_code %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([first, second, third | _]) do
    resistance = (10 * @color_code[first] + @color_code[second]) * 10 ** @color_code[third]

    kiloohms_limit = 10 ** 3
    megaohms_limit = 10 ** 6
    gigaohms_limit = 10 ** 9

    cond do
      resistance < kiloohms_limit -> {resistance, :ohms}
      resistance < megaohms_limit -> {resistance / kiloohms_limit, :kiloohms}
      resistance < gigaohms_limit -> {resistance / megaohms_limit, :megaohms}
      true -> {resistance / gigaohms_limit, :gigaohms}
    end
  end
end
