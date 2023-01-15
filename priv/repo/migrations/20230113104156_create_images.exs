defmodule CG.Repo.Migrations.CreateMedia do
  use Ecto.Migration

  def change do
    create table(:media) do
      add(:path, :string)
      add(:extension, :string)
      add(:state, :smallint)

      timestamps()
    end
  end
end
