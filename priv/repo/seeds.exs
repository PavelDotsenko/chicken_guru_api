# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CG.Repo.insert!(%CG.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias CG.Service.{LanguageService, CategoryService, AccountService}

{:ok, lang} =
  %{
    "language" => %{
      "title" => "Русский",
      "code" => "rus"
    }
  }
  |> LanguageService.create()

{:ok, _category} =
  %{
    "category" => %{
      "title" => "Первые блюда",
      "language_id" => lang.id
    }
  }
  |> CategoryService.create()

{:ok, _account} =
  %{
    "account" => %{
      "language_id" => lang.id,
      "email" => "pavel_dotsenko@hotmail.com",
      "password" => "1234",
      "repassword" => "1234"
    }
  }
  |> AccountService.create()
