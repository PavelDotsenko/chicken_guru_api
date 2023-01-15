defmodule CG.Repository.Language do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repo
  alias Helper.ChangesetHelper

  schema "languages" do
    field(:code, :string)
    field(:title, :string)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:title, :code])
    |> validate_required([:title, :code])
    |> ChangesetHelper.normalize_string([:title, :code])
    |> ChangesetHelper.security_check([:title, :code])
    |> validate_length(:title, min: 3, max: 64)
    |> validate_length(:code, is: 3)
    |> unsafe_validate_unique([:title, :code], Repo)
  end
end
