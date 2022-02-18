defmodule CG.Repository.RecipeStep do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.Recipe
  alias CG.Phrase
  alias CG.Helpers.ChangesetHelper

  schema "recipe_steps" do
    field :number, :integer
    field :title, :string
    field :description, :string
    field :optional, :boolean

    belongs_to :recipe, Recipe
    belongs_to :attached_recipe, Recipe

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = recipe_step, attrs) do
    recipe_step
    |> cast(attrs, [
      :number,
      :title,
      :description,
      :recipe_id,
      :optional,
      :attached_recipe_id
    ])
    |> validate_required(:number, message: Phrase.number_is_empty())
    |> validate_required(:title, message: Phrase.title_is_empty())
    |> validate_required(:recipe_id, message: Phrase.recipe_step_not_selected())
    |> ChangesetHelper.normalize_string([:title, :description])
    |> ChangesetHelper.security_check(:title, message: Phrase.title_contains_invalid_characters())
    |> ChangesetHelper.security_check(:description, message: Phrase.description_contains_invalid_characters())
    |> validate_number(:number, greater_than: 0, message: Phrase.number_cannot_be_less_than_zero())
  end
end
