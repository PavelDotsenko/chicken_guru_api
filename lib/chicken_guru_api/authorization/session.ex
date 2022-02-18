defmodule CG.Session do
  @table :session

  def init_session(), do: :ets.new(@table, [:named_table, :public])

  def write(data \\ %{}) do
    session_key =
      Ecto.UUID.generate()
      |> str_to_atom()

    :ets.insert(@table, [{session_key, data, NaiveDateTime.utc_now()}])

    session_key
  end

  def write(session_key, data) do
    session_key
    |> str_to_atom()
    |> read()
    |> case do
      nil -> nil
      session_data -> :ets.insert(@table, [{session_key, Map.merge(session_data, data)}])
    end

    session_key
  end

  def read(session_key) do
    case :ets.lookup(@table, str_to_atom(session_key)) do
      [] -> nil
      [{_, data, _}] -> data
    end
  end

  def exists?(session_key), do: read(session_key) != nil

  defp str_to_atom(str) when is_atom(str), do: str
  defp str_to_atom(str) when is_bitstring(str), do: String.to_atom(str)
  defp str_to_atom(_), do: :""
end
