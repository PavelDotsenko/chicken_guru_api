defmodule CG.Repository.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Repository.{Language}
  alias Helper.ChangesetHelper

  schema "categories" do
    field(:title, :string)
    field(:is_folder, :boolean)

    belongs_to(:language, Language)
    belongs_to(:parent, __MODULE__)
    has_many(:children, __MODULE__, foreign_key: :parent_id)

    timestamps()
  end

  use Helper.BaseRepository, repo: CG.Repo

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :parent_id, :is_folder, :language_id])
    |> validate_required([:title, :language_id])
    |> ChangesetHelper.normalize_string([:title])
    |> ChangesetHelper.security_check([:title])
    |> validate_length(:title, min: 3, max: 64)
    |> unsafe_validate_unique([:title, :language_id], Repo)
  end
end
