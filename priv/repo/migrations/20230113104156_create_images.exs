defmodule CG.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add(:path, :string)
      add(:extension, :string)
      add(:state, :smallint)

      timestamps()
    end
  end
end
