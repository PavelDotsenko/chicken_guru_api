defmodule CG.Repository.CategoryForRecipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.Recipe
  alias CG.Repository.Category
  alias CG.Phrase

  schema "categories_for_recipes" do
    belongs_to :recipe, Recipe
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = category_for_recipe, attrs) do
    category_for_recipe
    |> cast(attrs, [:recipe_id, :category_id])
    |> validate_required(:recipe_id, message: Phrase.no_recipe_selected())
    |> validate_required(:category_id, message: Phrase.no_category_selected())
  end
end
