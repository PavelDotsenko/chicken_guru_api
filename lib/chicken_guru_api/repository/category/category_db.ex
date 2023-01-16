defmodule CG.Repository.Category.Db do
  import Ecto.Query

  alias CG.Repo
  alias CG.Repository.{Category, Language}

  def list(filter \\ nil) do
    language = from(l in Language, select: l.code)
    children = from(c in Category, preload: [:children, language: ^language], select: c)
    children = from(c in Category, preload: [children: ^children, language: ^language], select: c)
    children = from(c in Category, preload: [children: ^children, language: ^language], select: c)

    query =
      from(
        c in Category,
        where: is_nil(c.parent_id) and c.is_folder == true,
        preload: [children: ^children, language: ^language],
        select: c
      )

    if is_nil(filter) do
      query
    else
      query
    end
    |> Repo.all()
  end
end
