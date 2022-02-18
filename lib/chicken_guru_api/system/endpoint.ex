defmodule CGWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :chicken_guru_api

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug CGWeb.Router
end
