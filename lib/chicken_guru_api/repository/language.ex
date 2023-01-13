defmodule CG.Repository.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field(:code, :string)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:title, :code])
    |> validate_required([:title, :code])
  end
end
