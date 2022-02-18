defmodule CG.Repository.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Types.LanguageType
  alias CG.Types.UnitType
  alias CG.Phrase
  alias CG.Helpers.ChangesetHelper

  schema "products" do
    field :title, :string
    field :weight, :float
    field :language, LanguageType
    field :unit, UnitType

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = product, attrs) do
    product
    |> cast(attrs, [:title, :weight, :language, :unit])
    |> validate_required(:title, message: Phrase.title_is_empty())
    |> validate_required(:language, message: Phrase.no_language_selected())
    |> validate_required(:unit, message: Phrase.no_unit_selected())
    |> ChangesetHelper.normalize_string([:title])
    |> ChangesetHelper.security_check(:title, message: Phrase.title_contains_invalid_characters())
    |> ChangesetHelper.enum_type_check(:language, LanguageType, message: Phrase.unsupported_language_selected())
    |> ChangesetHelper.enum_type_check(:unit, UnitType, message: Phrase.unsupported_unit_selected())
    |> validate_length(:title, max: 128, message: Phrase.maximum_title_length_128_characters())
    |> update_change(:title, &String.downcase/1)
    |> unsafe_validate_unique(:title, CG.Repo, message: Phrase.title_is_not_unique())
  end
end
