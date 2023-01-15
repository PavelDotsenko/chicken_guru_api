defmodule CGWeb.PrepareForRest do
  def prepare(%Date{} = value) do
    Date.to_iso8601(value)
  end

  def prepare(%Time{} = value) do
    Time.to_iso8601(value)
  end

  def prepare(%DateTime{} = value) do
    Calendar.strftime(value, "20%y.%m.%d %I:%M:%S")
  end

  def prepare(%NaiveDateTime{} = value) do
    {:ok, value} = DateTime.from_naive(value, "Etc/UTC")
    Calendar.strftime(value, "20%y.%m.%d %I:%M:%S")
  end

  def prepare(%Ecto.Association.NotLoaded{}), do: nil

  def prepare({:error, val}), do: prepare(val)

  def prepare(struct) when is_struct(struct) do
    Map.from_struct(struct)
    |> Map.drop([:__meta__, :__struct__])
    |> prepare()
  end

  def prepare(map) when is_map(map) do
    Enum.map(map, fn {key, value} -> {key, prepare(value)} end)
    |> Map.new()
    |> Map.delete("delete_thiss")
  end

  def prepare(list) when is_list(list) do
    Enum.map(list, fn value -> prepare(value) end)
  end

  def prepare(tuple) when is_tuple(tuple) do
    Tuple.to_list(tuple)
    |> prepare()
  end

  def prepare(value) when is_pid(value), do: value

  def prepare(value), do: value
end
