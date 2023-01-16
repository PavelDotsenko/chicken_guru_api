defmodule CGWeb.Controller.AccountController do
  use CGWeb, :controller

  alias CG.Service.AccountService
  alias CG.Repository.Account

  def create(conn, params) do
    params
    |> AccountService.create()
    |> check_throw()
    |> view_handler()
    |> response(conn)
  end

  def view_handler({:ok, %Account{} = acc}) do
    data = %{
      email: acc.email,
      name: acc.name,
      about: acc.about,
      state: acc.state
    }

    {:ok, data}
  end

  def view_handler(any), do: any
end
