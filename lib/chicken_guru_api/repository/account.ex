defmodule CG.Repository.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Image, Language}

  schema "accounts" do
    field(:about, :string)
    field(:email, :string)
    field(:is_admin, :boolean, default: false)
    field(:name, :string)
    field(:password, :string)
    field(:state, :integer)

    belongs_to(:avatar, Image)
    belongs_to(:language, Language)

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :password, :name, :about, :is_admin, :state, :avatar_id, :language_id])
    |> validate_required([:email, :password, :name, :about, :is_admin, :state])
  end
end
