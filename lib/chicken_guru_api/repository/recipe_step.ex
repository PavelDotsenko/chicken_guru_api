defmodule CG.Repository.RecipeStep do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Recipy}

  schema "recipe_steps" do
    field(:description, :string)
    field(:number, :integer)
    field(:optional, :boolean, default: false)
    field(:title, :string)

    belongs_to(:recipe, Recipy)
    belongs_to(:attached_recipe, Recipy)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(recipe_step, attrs) do
    recipe_step
    |> cast(attrs, [:number, :title, :description, :optional, :recipe_id, :attached_recipe_id])
    |> validate_required([
      :number,
      :title,
      :description,
      :optional,
      :recipe_id,
      :attached_recipe_id
    ])
  end
end
