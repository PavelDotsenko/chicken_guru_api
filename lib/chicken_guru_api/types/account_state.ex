defmodule CG.Types.AccountState do
  use EctoEnum.Postgres,
    type: :account_state,
    enums: [:active, :blocked, :deleted]

  @type type :: :active | :blocked | :deleted
end
