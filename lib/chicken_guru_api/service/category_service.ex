defmodule CG.Service.CategoryService do
  use Helper.BaseService

  alias CG.Repository.Category

  def create(attr) do
    required_param(attr, "category")
    required_param(attr["category"], ["title", "language_id"])

    Category.add(attr["category"])
  end

  def list do
    Category.get_all()
  end

  def update(attr) do
    required_param(attr, "id")
    required_param(attr, "category")
  end

  def delete(attr) do
    required_param(attr, "category")
    required_param(attr["category"], ["code"])

    with {:ok, lang} <- Category.get(code: attr["category"]["code"]) |> IO.inspect(),
         {:ok, _} <- Category.delete(lang) |> IO.inspect() do
      {:ok, "category is deleted"}
    end
  end
end
