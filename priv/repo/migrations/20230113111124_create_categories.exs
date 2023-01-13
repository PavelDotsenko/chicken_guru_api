defmodule CG.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add(:title, :string)
      add(:parent_id, references(:categories))
      add(:language_id, references(:languages))

      timestamps()
    end

    create(index(:categories, [:language_id]))
  end
end
