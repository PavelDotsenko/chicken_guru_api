defmodule CG.Repository.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Language}

  schema "products" do
    field(:title, :string)
    field(:unit, :string)
    field(:weight, :float)

    belongs_to(:language, Language)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :weight, :unit, :language_id])
    |> validate_required([:title, :weight, :unit, :language_id])
  end
end
