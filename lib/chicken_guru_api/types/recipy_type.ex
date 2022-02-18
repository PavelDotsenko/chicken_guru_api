defmodule CG.Types.RecipeType do
  use EctoEnum.Postgres,
    type: :recipe_type,
    enums: [:saved, :awaiting_confirmation, :published, :blocked, :hidden, :deleted]

  @type type :: :saved | :awaiting_confirmation | :published | :blocked | :hidden | :deleted
end
