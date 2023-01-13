defmodule CG.Repository.Recipy do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Language, Account, CategoryForRecipy}

  schema "recipes" do
    field(:cooking_time, :integer)
    field(:description, :string)
    field(:likes_count, :integer)
    field(:number_of_persons, :integer)
    field(:state, :integer)
    field(:title, :string)
    field(:views_count, :integer)

    belongs_to(:language, Language)
    belongs_to(:account, Account)

    has_many(:categories, CategoryForRecipy, foreign_key: :recipe_id)

    timestamps()
  end

  @doc false
  def changeset(recipy, attrs) do
    recipy
    |> cast(attrs, [
      :title,
      :description,
      :cooking_time,
      :number_of_persons,
      :likes_count,
      :views_count,
      :state,
      :language_id,
      :account_id
    ])
    |> validate_required([
      :title,
      :description,
      :cooking_time,
      :number_of_persons,
      :likes_count,
      :views_count,
      :state,
      :language_id,
      :account_id
    ])
  end
end
