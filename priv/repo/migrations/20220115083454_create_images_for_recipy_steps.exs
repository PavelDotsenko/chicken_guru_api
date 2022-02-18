defmodule CG.Repo.Migrations.CreateImagesForRecipeSteps do
  use Ecto.Migration

  def change do
    create table(:images_for_recipe_steps) do
      add :recipe_step_id, references(:recipe_steps), null: false
      add :image_id, references(:images), null: false
      add :preview, :boolean, nul: false, default: false

      timestamps()
    end
  end
end
