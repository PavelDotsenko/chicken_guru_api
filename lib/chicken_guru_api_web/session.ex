defmodule CGWeb.Session do
  use GenServer

  import Plug.Conn

  @token_max_age Application.get_env(:chicken_guru_api, :token_max_age)
  @iso_time_offset Application.get_env(:chicken_guru_api, :iso_time_offset)

  def init(_opts), do: {:ok, []}

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def call(conn, _opts) do
    conn
    |> read()
    |> authenticate(conn)
  end

  defp authenticate({:ok, %{type: :client, secret_key: key, id: id, data: data}}, conn) do
    ApiCore.Repository.Account.get(id: id, code: key)
    |> case do
      {:ok, _} ->
        Map.put(conn, :private, Map.merge(conn.private, %{plug_session: %{"client" => data}}))

      {:error, _} ->
        authenticate({:error, ""}, conn)
    end
  end

  defp authenticate({:error, _error}, conn) do
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
  end

  def read(%Plug.Conn{req_headers: headers}) do
    read_token(Map.new(headers)["authorization"])
  end

  def put(%Plug.Conn{req_headers: headers} = conn, token) do
    headers =
      Map.put(Map.new(headers), "authorization", "Bearer " <> token)
      |> Enum.map(& &1)

    Map.put(conn, :req_headers, headers)
  end

  def write(%{type: _type, secret_key: _secret_key, id: _id, data: _data} = data) do
    date_time =
      DateTime.utc_now()
      |> DateTime.add(@token_max_age * 6)
      |> DateTime.add(@token_max_age)
      |> DateTime.to_unix()

    token =
      Phoenix.Token.sign(
        CGWeb.Endpoint,
        Application.get_env(:chicken_guru_api, :session_salt),
        data,
        max_age: @token_max_age,
        key_digest: :sha512
      )

    %{
      access_token: token,
      expires_on: date_time,
      token_type: "Bearer"
    }
  end

  def get_token(%Plug.Conn{req_headers: headers}) do
    token = Map.new(headers)["authorization"]
    if token, do: Regex.replace(~r/^Bearer\ /, token, ""), else: nil
  end

  def read_token(nil), do: {:error, :no_token}

  def read_token(token) do
    new_token = Regex.replace(~r/^Bearer\ /, token, "")

    if token != new_token do
      Phoenix.Token.verify(
        CGWeb.Endpoint,
        Application.get_env(:chicken_guru_api, :session_salt),
        new_token,
        max_age: @token_max_age,
        key_digest: :sha512
      )
    else
      {:error, :invalid}
    end
  end
end
