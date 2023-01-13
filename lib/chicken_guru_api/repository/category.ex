defmodule CG.Repository.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Language}

  schema "categories" do
    field(:title, :string)

    belongs_to(:language, Language)
    belongs_to(:parent, __MODULE__)
    has_many(:children, __MODULE__, foreign_key: :parent_id)

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :parent_id, :language_id])
    |> validate_required([:title, :parent_id, :language_id])
  end
end
