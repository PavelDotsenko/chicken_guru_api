defmodule CG.Repository.ProductInUnit do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Recipy, Product, Unit}

  schema "product_in_units" do
    field(:quantity, :float)

    belongs_to(:recipe, Recipy)
    belongs_to(:product, Product)
    belongs_to(:unit, Unit)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(product_in_unit, attrs) do
    product_in_unit
    |> cast(attrs, [:quantity, :recipe_id, :product_id, :unit_id])
    |> validate_required([:quantity, :recipe_id, :product_id, :unit_id])
  end
end
