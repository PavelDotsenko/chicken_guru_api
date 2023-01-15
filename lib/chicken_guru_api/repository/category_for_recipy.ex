defmodule CG.Repository.CategoryForRecipy do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Recipy, Category}

  schema "category_for_recipes" do
    belongs_to(:recipe, Recipy)
    belongs_to(:category, Category)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(category_for_recipy, attrs) do
    category_for_recipy
    |> cast(attrs, [:recipe_id, :category_id])
    |> validate_required([:recipe_id, :category_id])
  end
end
