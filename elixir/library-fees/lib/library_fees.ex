defmodule LibraryFees do
  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, datetime} -> datetime
      {:error, _} -> {:error, "Invalid datetime string"}
    end
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    case checkout_datetime do
      x when x.hour < 12 -> Date.add(checkout_datetime, 28)
      _ -> Date.add(checkout_datetime, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    case Date.diff(actual_return_datetime, planned_return_date) do
      x when x < 0 -> 0
      x -> x
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    planned_return_date = return_date(datetime_from_string(checkout))
    actual_return_datetime = datetime_from_string(return)
    days_late = days_late(planned_return_date, actual_return_datetime)
    is_monday = monday?(actual_return_datetime)

    case {is_monday, days_late} do
      {true, 0} -> 0
      {true, x} -> trunc(x * rate / 2)
      {false, 0} -> 0
      {false, x} -> x * rate
    end
  end
end
