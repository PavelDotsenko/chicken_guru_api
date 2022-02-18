defmodule CG.Repository.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias CG.Helpers.ChangesetHelper
  alias CG.Phrase

  schema "images" do
    field :path, :string
    field :extension, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = image, attrs) do
    image
    |> cast(attrs, [:path, :extension])
    |> validate_required(:path, message: Phrase.file_path_not_specified())
    |> validate_required(:extension, message: Phrase.file_extension_not_specified())
    |> ChangesetHelper.normalize_string([:path, :extension])
    |> ChangesetHelper.security_check(:path, message: Phrase.path_contains_invalid_characters())
    |> ChangesetHelper.security_check(:extension, message: Phrase.extension_contains_invalid_characters())
  end
end
