defmodule CG.Repository.Media do
  use Ecto.Schema
  import Ecto.Changeset

  schema "media" do
    field(:extension, :string)
    field(:path, :string)
    field(:state, :integer)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:path, :extension, :state])
    |> validate_required([:path, :extension, :state])
  end
end
