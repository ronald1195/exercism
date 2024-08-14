defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, :battery_percentage, :distance_driven_in_meters]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname, battery_percentage: 100, distance_driven_in_meters: 0}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      _ -> "Battery at #{remote_car.battery_percentage}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    case remote_car.battery_percentage do
      0 ->
        remote_car

      _ ->
        %RemoteControlCar{
          remote_car
          | distance_driven_in_meters: remote_car.distance_driven_in_meters + 20,
            battery_percentage: remote_car.battery_percentage - 1
        }
    end
  end
end
