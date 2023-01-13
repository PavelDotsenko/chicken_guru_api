defmodule CG.Repository.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Language}

  schema "units" do
    field(:code, :string)
    field(:title, :string)

    belongs_to(:language, Language)

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:title, :code, :language_id])
    |> validate_required([:title, :code, :language_id])
  end
end
