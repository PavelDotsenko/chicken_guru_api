defmodule CG.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  alias CG.Types.LanguageType
  alias CG.Types.UnitType

  def change do
    create table(:products) do
      add :title, :string, null: false, size: 128
      add :weight, :float, null: false, default: 0.0
      add :language, LanguageType.type(), null: false
      add :unit, UnitType.type(), null: false

      timestamps()
    end

    create index(:products, [:language], using: :hash)
  end
end
