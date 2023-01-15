defmodule CGWeb.Controller.AccountController do
  use CGWeb, :controller

  alias CG.Service.AccountService

  def create(conn, params) do
    params
    |> AccountService.create()
    |> check_throw()
    |> response(conn)
  end
end
