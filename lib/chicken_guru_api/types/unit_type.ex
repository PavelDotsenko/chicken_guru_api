defmodule CG.Types.UnitType do
  use EctoEnum.Postgres,
    type: :unit_type,
    enums: [
      :gram,
      :milliliter,
      :tea_spoon,
      :heaped_teaspoon,
      :tablespoon,
      :heaped_tablespoon,
      :tea_glass,
      :faceted_glass,
      :thing,
      :to_taste
    ]

  @type type ::
          :gram
          | :milliliter
          | :tea_spoon
          | :heaped_teaspoon
          | :tablespoon
          | :heaped_teaspoon
          | :tea_glass
          | :faceted_glass
          | :thing
          | :to_taste
end
