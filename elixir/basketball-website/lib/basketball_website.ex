defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_array = String.split(path, ".")
    do_extract_from_path(data, path_array)
  end

  defp do_extract_from_path(data, []) do
    data
  end

  defp do_extract_from_path(data, [hd | rest]) do
    case data[hd] do
      nil -> nil
      _ -> do_extract_from_path(data[hd], rest)
    end
  end

  def get_in_path(data, path) do
    path_array = String.split(path, ".")
    get_in(data, path_array)
  end
end
