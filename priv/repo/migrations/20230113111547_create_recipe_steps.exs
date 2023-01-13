defmodule CG.Repo.Migrations.CreateRecipeSteps do
  use Ecto.Migration

  def change do
    create table(:recipe_steps) do
      add(:number, :integer)
      add(:title, :string)
      add(:description, :text)
      add(:optional, :boolean, default: false, null: false)
      add(:recipe_id, references(:recipes))
      add(:attached_recipe_id, references(:recipes))

      timestamps()
    end

    create(index(:recipe_steps, [:recipe_id]))
  end
end
