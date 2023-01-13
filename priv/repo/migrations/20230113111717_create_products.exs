defmodule CG.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:title, :string)
      add(:weight, :float)
      add(:unit, references(:units))
      add(:language_id, references(:languages))

      timestamps()
    end

    create(index(:products, [:language_id]))
  end
end
