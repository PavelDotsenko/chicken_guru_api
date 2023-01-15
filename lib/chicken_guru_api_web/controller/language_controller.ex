defmodule CGWeb.Controller.LanguageController do
  use CGWeb, :controller

  alias CG.Service.LanguageService

  def create(conn, params) do
    params
    |> LanguageService.create()
    |> check_throw()
    |> response(conn)
  end

  def list(conn, params) do
    params
    |> LanguageService.list()
    |> check_throw()
    |> response(conn)
  end

  def update(conn, params) do
    params
    |> LanguageService.update()
    |> check_throw()
    |> response(conn)
  end

  def delete(conn, params) do
    params
    |> LanguageService.delete()
    |> check_throw()
    |> response(conn)
  end
end
