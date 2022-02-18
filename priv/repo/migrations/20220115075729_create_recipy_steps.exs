defmodule CG.Repo.Migrations.CreateRecipeSteps do
  use Ecto.Migration

  def change do
    create table(:recipe_steps) do
      add :recipe_id, references(:recipes), null: false
      add :number, :integer, null: false
      add :title, :string, null: false, size: 128
      add :description, :text
      add :attached_recipe_id, references(:recipes)
      add :optional, :boolean, null: false, default: false

      timestamps()
    end
  end
end
