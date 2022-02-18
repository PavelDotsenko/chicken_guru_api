defmodule CG.Repository.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Phrase
  alias CG.Types.{LanguageType, AccountState}

  alias CG.Helpers.{ChangesetHelper, CryptoHelper}

  alias CG.Repository.{Image, Recipe}

  schema "accounts" do
    field :login, :string
    field :password, :string
    field :name, :string
    field :about, :string
    field :is_admin, :boolean
    field :language, LanguageType
    field :state, AccountState

    belongs_to :avatar, Image
    belongs_to :background, Image

    has_many :recipe, Recipe
    
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = account, attrs) do
    account
    |> cast(attrs, [
      :login,
      :password,
      :name,
      :about,
      :language,
      :state,
      :avatar_id,
      :background_id,
      :is_admin
    ])
    |> validate_required(:login, message: Phrase.login_is_empty())
    |> validate_required(:password, message: Phrase.password_is_empty())
    |> validate_required(:language, message: Phrase.language_is_empty())
    |> ChangesetHelper.normalize_string([:login, :password, :name, :about])
    |> ChangesetHelper.security_check(:login, message: Phrase.login_contains_invalid_characters())
    |> ChangesetHelper.security_check(:name, message: Phrase.name_contains_invalid_characters())
    |> ChangesetHelper.security_check(:about,
      message: Phrase.description_contains_invalid_characters()
    )
    |> ChangesetHelper.email_check(:login,
      format_message: Phrase.invalid_login_format(),
      unique_message: Phrase.login_is_not_unique()
    )
    |> ChangesetHelper.enum_type_check(:language, LanguageType,
      message: Phrase.unsupported_language_selected()
    )
    |> ChangesetHelper.enum_type_check(:state, AccountState,
      message: Phrase.unsupported_state_selected()
    )
    |> validate_length(:password, min: 4, message: Phrase.minimum_password_length_4_characters())
    |> update_change(:password, &CryptoHelper.hash/1)
  end
end
