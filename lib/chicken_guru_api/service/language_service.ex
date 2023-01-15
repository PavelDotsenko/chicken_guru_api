defmodule CG.Service.LanguageService do
  use Helper.BaseService

  alias CG.Repository.Language

  def create(attr) do
    required_param(attr, "language")
    required_param(attr["language"], ["code", "title"])

    Language.add(attr["language"])
  end

  def list do
    Language.get_all()
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
