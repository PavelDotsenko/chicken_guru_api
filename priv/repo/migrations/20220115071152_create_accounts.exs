defmodule CG.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  alias CG.Types.LanguageType
  alias CG.Types.AccountState

  def change do
    create table(:accounts) do
      add :login, :string, null: false, size: 64
      add :password, :string, null: false, size: 128
      add :name, :string
      add :about, :text
      add :is_admin, :boolean, null: false, default: false
      add :avatar_id, references(:images)
      add :background_id, references(:images)
      add :language, LanguageType.type(), null: false
      add :state, AccountState.type(), null: false, default: "active"

      timestamps()
    end

    create index(:accounts, [:is_admin], using: :hash)
  end
end
