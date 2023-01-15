defmodule CG.Service.CategoryService do
  use Helper.BaseService

  alias CG.Repository.Category

  def create(attr) do
    required_param(attr, "category")
    required_param(attr["category"], ["title", "language_id"])

    Category.add(attr["category"])
  end

  def list(attr) do
    data =
      if attr == %{} do
        Category.get_all!()
      else
        attr
        |> Map.to_list()
        |> Category.get_all()
      end

    {:ok, data}
  end

  def update(attr) do
    required_param(attr, ["id", "category"])

    with {:ok, category} <- Category.get(attr["id"]),
         {:ok, updated} <- Category.update(attr["category"]) do
      {:ok, updated}
    end
  end

  def delete(attr) do
    required_param(attr, "category")
    required_param(attr["category"], ["id"])

    with {:ok, category} <- Category.get(attr["category"]["id"]),
         {:ok, _} <- Category.delete(category) do
      {:ok, "category is deleted"}
    end
  end
end
