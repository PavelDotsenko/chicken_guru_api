defmodule CG.Repository.ProductInUnit do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Types.UnitType
  alias CG.Phrase
  alias CG.Repository.Recipe
  alias CG.Repository.Product

  alias CG.Helpers.ChangesetHelper

  schema "products_in_units" do
    field :quantity, :float
    field :unit, UnitType

    belongs_to :recipe, Recipe
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = product_in_unit, attrs) do
    product_in_unit
    |> cast(attrs, [:recipe_id, :product_id, :quantity, :unit])
    |> validate_required(:recipe_id, message: Phrase.no_recipe_selected())
    |> validate_required(:product_id, message: Phrase.no_product_selected())
    |> validate_required(:quantity, message: Phrase.no_quantity_selected())
    |> validate_required(:unit, message: Phrase.no_unit_selected())
    |> ChangesetHelper.enum_type_check(:unit, UnitType, message: Phrase.unsupported_unit_selected())
  end
end
