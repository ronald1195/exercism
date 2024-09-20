defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-" <> Integer.to_string(Enum.random(1000..9999))
  end

  def random_stardate() do
    initial_star_date = Enum.random(41000..42000)

    if initial_star_date < 41999 do
      initial_star_date + :rand.uniform()
    else
      initial_star_date
    end
  end

  def format_stardate(stardate) do
    # Please implement the format_stardate/1 function
  end
end
