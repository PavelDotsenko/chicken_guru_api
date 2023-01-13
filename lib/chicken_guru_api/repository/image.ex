defmodule CG.Repository.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field(:extension, :string)
    field(:path, :string)
    field(:state, :integer)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:path, :extension, :state])
    |> validate_required([:path, :extension, :state])
  end
end
