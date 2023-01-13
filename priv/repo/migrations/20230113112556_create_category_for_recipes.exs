defmodule CG.Repo.Migrations.CreateCategoryForRecipes do
  use Ecto.Migration

  def change do
    create table(:category_for_recipes) do
      add(:recipe_id, references(:recipes))
      add(:category_id, references(:categories))

      timestamps()
    end

    create(index(:category_for_recipes, [:recipe_id]))
    create(index(:category_for_recipes, [:category_id]))
  end
end
