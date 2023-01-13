defmodule CG.Repository.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  alias CG.Repository.{Image, Language}

  defenum State, deleted: 0, active: 1, blocked: 2

  schema "accounts" do
    field(:about, :string)
    field(:email, :string)
    field(:is_admin, :boolean, default: false)
    field(:name, :string)
    field(:password, :string)
    field(:repassword, :string, virtual: true)
    field(:state, State, default: :active)

    belongs_to(:avatar, Image)
    belongs_to(:language, Language)

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :password, :name, :about, :is_admin, :state, :avatar_id, :language_id])
    |> validate_required([:email, :password, :is_admin, :language_id])
  end
end
