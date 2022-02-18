defmodule CG.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  alias CG.Types.LanguageType
  alias CG.Types.RecipeType

  def change do
    create table(:recipes) do
      add :author_id, references(:accounts)
      add :title, :string, null: false, size: 128
      add :description, :text
      add :cooking_time, :integer, null: false
      add :number_of_persons, :integer, null: false
      add :likes_count, :integer, null: false, default: 0
      add :views_count, :integer, null: false, default: 0
      add :language, LanguageType.type(), null: false
      add :state, RecipeType.type(), null: false, default: "saved"

      timestamps()
    end

    create index(:recipes, [:language], using: :hash)
  end
end
