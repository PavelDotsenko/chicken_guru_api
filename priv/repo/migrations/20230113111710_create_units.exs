defmodule CG.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units) do
      add(:title, :string)
      add(:code, :string)
      add(:language_id, references(:languages))

      timestamps()
    end

    create(index(:units, [:language_id]))
  end
end
