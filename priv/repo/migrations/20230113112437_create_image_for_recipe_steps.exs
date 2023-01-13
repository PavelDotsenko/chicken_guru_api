defmodule CG.Repo.Migrations.CreateImageForRecipeSteps do
  use Ecto.Migration

  def change do
    create table(:image_for_recipe_steps) do
      add(:preview, :boolean, default: false, null: false)
      add(:recipe_step_id, references(:recipe_steps))
      add(:image_id, references(:images))

      timestamps()
    end

    create(index(:image_for_recipe_steps, [:recipe_step_id]))
  end
end
