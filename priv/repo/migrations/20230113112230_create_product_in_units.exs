defmodule CG.Repo.Migrations.CreateProductInUnits do
  use Ecto.Migration

  def change do
    create table(:product_in_units) do
      add(:quantity, :float)
      add(:recipe_id, references(:recipes))
      add(:product_id, references(:products))
      add(:unit_id, references(:units))

      timestamps()
    end

    create(index(:product_in_units, [:recipe_id]))
    create(index(:product_in_units, [:product_id]))
  end
end
