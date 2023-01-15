defmodule CGWeb.Controller.CategoryController do
  use CGWeb, :controller

  alias CG.Service.CategoryService

  def create(conn, params) do
    params
    |> CategoryService.create()
    |> check_throw()
    |> response(conn)
  end

  def list(conn, params) do
    params
    |> CategoryService.list()
    |> check_throw()
    |> response(conn)
  end

  def update(conn, params) do
    params
    |> CategoryService.update()
    |> check_throw()
    |> response(conn)
  end

  def delete(conn, params) do
    params
    |> CategoryService.delete()
    |> check_throw()
    |> response(conn)
  end
end
