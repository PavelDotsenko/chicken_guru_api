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

{:ok, category} =
  %{
    "category" => %{
      "title" => "Первые блюда",
      "language_id" => lang.id,
      "is_folder" => true
    }
  }
  |> CategoryService.create()

{:ok, _category} =
  %{
    "category" => %{
      "title" => "Вторые блюда",
      "language_id" => lang.id,
      "is_folder" => true
    }
  }
  |> CategoryService.create()

{:ok, category2} =
  %{
    "category" => %{
      "title" => "Холодные супы",
      "language_id" => lang.id,
      "parent_id" => category.id,
      "is_folder" => true
    }
  }
  |> CategoryService.create()

{:ok, category3} =
  %{
    "category" => %{
      "title" => "Борщи",
      "language_id" => lang.id,
      "parent_id" => category2.id
    }
  }
  |> CategoryService.create()

  {:ok, category3} =
    %{
      "category" => %{
        "title" => "Зеленые борщи",
        "language_id" => lang.id,
        "parent_id" => category3.id
      }
    }
    |> CategoryService.create()

{:ok, _category} =
  %{
    "category" => %{
      "title" => "Похлебки",
      "language_id" => lang.id,
      "parent_id" => category.id
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
