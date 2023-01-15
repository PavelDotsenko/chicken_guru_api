defmodule CG.Repository.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  alias CG.Repository.{Media, Language}
  alias CG.Repo
  alias Helper.{ChangesetHelper, CryptoHelper}

  defenum State, deleted: 0, active: 1, blocked: 2

  schema "accounts" do
    field(:is_admin, :boolean, default: false)
    field(:email, :string)
    field(:name, :string)
    field(:about, :string)
    field(:password, :string)
    field(:repassword, :string, virtual: true)
    field(:state, State, default: :active)

    belongs_to(:avatar, Media)
    belongs_to(:language, Language)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :password, :repassword, :name, :about, :is_admin, :state, :avatar_id, :language_id])
    |> validate_required([:email, :password, :repassword, :is_admin, :language_id])
    |> ChangesetHelper.normalize_string([:email, :password, :repassword, :name, :about])
    |> ChangesetHelper.security_check([:email, :password, :repassword, :name, :about])
    |> ChangesetHelper.email_check(:email)
    |> unsafe_validate_unique(:email, Repo)
    |> validate_length(:password, min: 4, max: 64)
    |> validate_length(:name, min: 3, max: 64)
    |> ChangesetHelper.password_check(:password, :repassword)
    |> update_change(:password, &CryptoHelper.hash64/1)
    |> ChangesetHelper.enum_type_check(:state, State)
  end
end
