defmodule CG.Service.LanguageService do
  use Helper.BaseService

  alias CG.Repository.Language

  def create(attr) do
    required_param(attr, "language")
    required_param(attr["language"], ["code", "title"])

    Language.add(attr["language"])
  end

  def list(attr) do
    data =
      if attr == %{} do
        Language.get_all!()
      else
        attr
        |> Map.to_list()
        |> Language.get_all()
      end

    {:ok, data}
  end

  def update(attr) do
    required_param(attr, ["id", "language"])

    with {:ok, lang} <- Language.get(code: attr["id"]),
         {:ok, updated} <- Language.update(attr["language"]) do
      {:ok, updated}
    end
  end

  def delete(attr) do
    required_param(attr, "language")
    required_param(attr["language"], ["code"])

    with {:ok, lang} <- Language.get(code: attr["language"]["code"]) |> IO.inspect(),
         {:ok, _} <- Language.delete(lang) |> IO.inspect() do
      {:ok, "language is deleted"}
    end
  end
end
