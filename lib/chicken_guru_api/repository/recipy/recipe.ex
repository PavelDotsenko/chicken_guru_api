defmodule CG.Repository.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Phrase

  alias CG.Types.{LanguageType, RecipeType}

  alias CG.Repository.{Account, CategoryForRecipe, RecipeStep, ProductInUnit}

  alias CG.Helpers.ChangesetHelper

  schema "recipes" do
    field :title, :string
    field :description, :string
    field :cooking_time, :integer
    field :number_of_persons, :integer
    field :likes_count, :integer
    field :views_count, :integer
    field :language, LanguageType
    field :state, RecipeType

    belongs_to :author, Account
    has_many :categories, CategoryForRecipe
    has_many :steps, RecipeStep
    has_many :products, ProductInUnit

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = recipe, attrs) do
    recipe
    |> cast(attrs, [
      :title,
      :description,
      :cooking_time,
      :number_of_persons,
      :language,
      :likes_count,
      :views_count,
      :state,
      :author_id
    ])
    |> validate_required(:title, message: Phrase.title_is_empty())
    |> validate_required(:number_of_persons, message: Phrase.number_of_persons_is_empty())
    |> validate_required(:language, message: Phrase.language_is_empty())
    |> validate_required(:author_id, message: Phrase.author_is_empty())
    |> ChangesetHelper.normalize_string([:title, :description])
    |> ChangesetHelper.security_check(:title, message: Phrase.title_contains_invalid_characters())
    |> ChangesetHelper.security_check(:description, message: Phrase.description_contains_invalid_characters())
    |> ChangesetHelper.enum_type_check(:language, LanguageType, message: Phrase.unsupported_language_selected())
    |> ChangesetHelper.enum_type_check(:state, RecipeType, message: Phrase.unsupported_state_selected())
    |> validate_length(:title, max: 128, message: Phrase.maximum_title_length_128_characters())
    |> validate_number(:likes_count, greater_than: 0, message: Phrase.likes_count_cannot_be_less_than_zero())
    |> validate_number(:views_count, greater_than: 0, message: Phrase.views_count_cannot_be_less_than_zero())
  end
end
