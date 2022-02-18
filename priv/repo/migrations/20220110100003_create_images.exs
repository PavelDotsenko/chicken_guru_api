defmodule CG.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :path, :string, null: false
      add :extension, :string, null: false

      timestamps()
    end
  end
end
