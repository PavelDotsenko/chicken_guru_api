defmodule CG.GraphQL.Middleware.SessionInsert do
  import Plug.Conn, only: [get_req_header: 2]

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)

    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Находит session-key в заголовке запроса,
  читае сессию для этого ключа и возвращает
  данные пользователя и session_key
  """
  def build_context(conn) do
    with {:ok, session_key} <- get_session_key(conn),
         {:ok, data} <- get_session_data(session_key) do
      Map.put(data, :session_key, session_key)
    else
      {:error, _} -> %{}
    end
  end

  defp get_session_key(conn) do
    case get_req_header(conn, "session-key") do
      [] -> {:error, nil}
      [session_key] -> {:ok, session_key}
    end
  end

  defp get_session_data(session_key) do
    case CG.Session.read(session_key) do
      nil -> {:error, nil}
      data -> {:ok, data}
    end
  end
end
