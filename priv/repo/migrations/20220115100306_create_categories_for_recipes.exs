defmodule CG.Repo.Migrations.CreateCategoriesForRecipes do
  use Ecto.Migration

  def change do
    create table(:categories_for_recipes) do
      add :recipe_id, references(:recipes)
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
