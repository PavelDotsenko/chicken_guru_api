defmodule CG.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add(:title, :string)
      add(:code, :string)
      add(:state, :smallint)

      timestamps()
    end
  end
end
