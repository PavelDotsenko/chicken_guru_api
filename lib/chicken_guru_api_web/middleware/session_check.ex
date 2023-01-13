defmodule CGWeb.Middleware.SessionCheck do
  use GenServer

  import Plug.Conn

  @iso_time_offset Application.get_env(:chicken_guru_api, :iso_time_offset)

  def init(type), do: type

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def call(conn, type) do
    conn
    |> get_session(type)
    |> case do
      nil ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          401,
          Jason.encode!(%{
            timestamptz:
              DateTime.utc_now() |> DateTime.to_iso8601(:extended, 3600 * @iso_time_offset),
            message: "Token missing or incorrect",
            errors: [],
            data: %{}
          })
        )
        |> halt()

      _ ->
        conn
    end
  end
end
