defmodule CG.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add(:title, :string)
      add(:description, :text)
      add(:cooking_time, :integer)
      add(:number_of_persons, :integer)
      add(:likes_count, :integer)
      add(:views_count, :integer)
      add(:state, :integer)
      add(:account_id, references(:accounts))
      add(:language_id, references(:languages))

      timestamps()
    end

    create(index(:recipes, [:account_id]))
    create(index(:recipes, [:language_id]))
  end
end
