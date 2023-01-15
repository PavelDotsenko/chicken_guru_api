defmodule CGWeb.Controller.AccountController do
  use CGWeb, :controller

  alias CG.Service.AccountService

  def create(conn, params) do
    AccountService.create(params)
    |> check_throw()
    |> response(conn)
  end
end
