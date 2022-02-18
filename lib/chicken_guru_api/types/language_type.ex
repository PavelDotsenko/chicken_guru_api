defmodule CG.Types.LanguageType do
  use EctoEnum.Postgres,
    type: :language_type,
    enums: [:rus]

  @type type :: :rus
end
