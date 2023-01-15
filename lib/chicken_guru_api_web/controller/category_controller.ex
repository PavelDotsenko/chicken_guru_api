defmodule CGWeb.Controller.CategoryController do
  use CGWeb, :controller

  alias CG.Service.LanguageService

  def create(conn, params) do
    LanguageService.create(params)
    |> check_throw()
    |> response(conn)
  end

  def list(conn, _params) do
    LanguageService.list()
    |> check_throw()
    |> response(conn)
  end

  def delete(conn, params) do
    LanguageService.delete(params)
    |> check_throw()
    |> response(conn)
  end
end
