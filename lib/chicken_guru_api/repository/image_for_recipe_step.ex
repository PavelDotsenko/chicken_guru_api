defmodule CG.Repository.ImageForRecipeStep do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.RecipeStep
  alias CG.Repository.Image
  alias CG.Phrase

  schema "images_for_recipe_steps" do
    field :preview, :boolean

    belongs_to :recipe_step, RecipeStep
    belongs_to :image, Image

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = image_for_recipe_step, attrs) do
    image_for_recipe_step
    |> cast(attrs, [:recipe_step_id, :image_id])
    |> validate_required(:recipe_step_id, message: Phrase.recipe_step_not_selected())
    |> validate_required(:image_id, message: Phrase.no_image_selected())
  end
end
