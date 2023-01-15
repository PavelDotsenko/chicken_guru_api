defmodule CG.Repository.ImageForRecipeStep do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Media, RecipeStep}

  schema "image_for_recipe_steps" do
    field(:preview, :boolean, default: false)

    belongs_to(:recipe_step, RecipeStep)
    belongs_to(:image, Media)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(image_for_recipe_step, attrs) do
    image_for_recipe_step
    |> cast(attrs, [:preview, :recipe_step_id, :image_id])
    |> validate_required([:preview, :recipe_step_id, :image_id])
  end
end
