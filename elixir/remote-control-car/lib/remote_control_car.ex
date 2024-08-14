defmodule RemoteControlCar do
  # Please implement the struct with the specified fields
  @enforce_keys [:nickname]
  defstruct [:nickname, :battery_percentage, :distance_driven_in_meters]
  def new() do
    # Please implement the new/0 function
    %RemoteControlCar{nickname: "none", battery_percentage: 100, distance_driven_in_meters: 0}
  end

  def new(nickname) do
    # Please implement the new/1 function
    %RemoteControlCar{nickname: nickname, battery_percentage: 100, distance_driven_in_meters: 0}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    # Please implement the display_distance/1 function
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    # Please implement the display_battery/1 function
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      _ -> "Battery at #{remote_car.battery_percentage}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    # Please implement the drive/1 function
    case remote_car.battery_percentage do
      0 -> remote_car
      _ -> %RemoteControlCar{remote_car | distance_driven_in_meters: remote_car.distance_driven_in_meters + 20, battery_percentage: remote_car.battery_percentage - 1}
    end
  end
end
