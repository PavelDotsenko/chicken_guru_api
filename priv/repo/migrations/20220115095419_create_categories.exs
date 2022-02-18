defmodule CG.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  alias CG.Types.LanguageType

  def change do
    create table(:categories) do
      add :title, :string
      add :language, LanguageType.type(), null: false

      timestamps()
    end

    create index(:categories, [:language], using: :hash)
  end
end
