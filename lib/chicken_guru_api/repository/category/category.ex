defmodule CG.Repository.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Types.LanguageType
  alias CG.Phrase
  alias CG.Helpers.ChangesetHelper

  schema "categories" do
    field :title, :string
    field :language, LanguageType

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = category, attrs) do
    category
    |> cast(attrs, [:title, :language])
    |> validate_required(:title, message: Phrase.title_is_empty())
    |> validate_required(:language, message: Phrase.language_is_empty())
    |> ChangesetHelper.normalize_string([:title])
    |> ChangesetHelper.security_check(:title, message: Phrase.title_contains_invalid_characters())
    |> ChangesetHelper.enum_type_check(:language, LanguageType,
      message: Phrase.unsupported_language_selected()
    )
    |> validate_length(:title, max: 128, message: Phrase.maximum_title_length_128_characters())
    |> update_change(:title, &String.downcase/1)
    |> unsafe_validate_unique(:title, CG.Repo, message: Phrase.title_is_not_unique())
  end
end
