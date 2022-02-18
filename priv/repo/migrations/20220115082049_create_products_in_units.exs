defmodule CG.Repo.Migrations.CreateProductsInUnits do
  use Ecto.Migration

  alias CG.Types.UnitType

  def change do
    create table(:products_in_units) do
      add :recipe_id, references(:recipes), null: false
      add :product_id, references(:products), null: false
      add :quantity, :float, null: false
      add :unit, UnitType.type(), null: false

      timestamps()
    end
  end
end
