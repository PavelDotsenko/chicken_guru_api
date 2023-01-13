defmodule CG.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add(:email, :string)
      add(:password, :string)
      add(:name, :string)
      add(:about, :text)
      add(:is_admin, :boolean, default: false, null: false)
      add(:state, :integer)
      add(:avatar_id, references(:images))
      add(:language_id, references(:languages))
      add(:state, :smallint)

      timestamps()
    end

    create(index(:accounts, [:is_admin]))
  end
end
