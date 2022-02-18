defmodule CG.Phrase do
  @phrases %{
    login_is_empty: %{rus: "Логин не может быть пустым"},
    password_is_empty: %{rus: "Пароль не может быть пустым"},
    language_is_empty: %{rus: "Не выбран язык"},
    name_is_empty: %{rus: "Имя не может быть пустым"},
    number_is_empty: %{rus: "Не указан номер"},
    title_is_empty: %{rus: "Название не может быть пустым"},
    number_of_persons_is_empty: %{rus: "Не выбрано количество персон"},
    author_is_empty: %{rus: "Автор не выбран"},
    login_contains_invalid_characters: %{rus: "Логин имеет недопустимые символы"},
    name_contains_invalid_characters: %{rus: "Имя имеет недопустимые символы"},
    description_contains_invalid_characters: %{rus: "Описание имеет недопустимые символы"},
    path_contains_invalid_characters: %{rus: "Путь до файла имеет недопустимые символы"},
    extension_contains_invalid_characters: %{rus: "Расширение файла имеет недопустимые символы"},
    title_contains_invalid_characters: %{rus: "Название имеет недопустимые символы"},
    invalid_login_format: %{rus: "Неверный формат логина"},
    login_is_not_unique: %{rus: "Логин не уникальный"},
    title_is_not_unique: %{rus: "Название не уникально"},
    unsupported_language_selected: %{rus: "Указан неподдерживаемый тип языка"},
    unsupported_state_selected: %{rus: "Указан неподдерживаемый статус"},
    no_recipe_selected: %{rus: "Не выбран рецепт"},
    no_category_selected: %{rus: "Не выбрана категория"},
    recipe_step_not_selected: %{rus: "Не выбран шаг рецепта"},
    no_image_selected: %{rus: "Не выбрано изображение"},
    no_product_selected: %{rus: "Не выбран продукт"},
    no_quantity_selected: %{rus: "Не выбрано количество"},
    no_unit_selected: %{rus: "Единица измерения не выбрана"},
    unsupported_unit_selected: %{rus: "Выбрана неподдерживаемая единица измерения"},
    no_language_selected: %{rus: "Язык не выбран"},
    minimum_password_length_4_characters: %{rus: "Минимальная длина пароля 4 символа"},
    maximum_title_length_128_characters: %{rus: "Максимальная длина названия 128 символа"},
    file_path_not_specified: %{rus: "Не указан путь до файла"},
    file_extension_not_specified: %{rus: "Не указано расширение файла"},
    number_cannot_be_less_than_zero: %{rus: "Номер не может быть меньше нуля"},
    likes_count_cannot_be_less_than_zero: %{rus: "Количество лайков не может быть меньше нуля"},
    views_count_cannot_be_less_than_zero: %{
      rus: "Количество просмотров не может быть меньше нуля"
    }
  }

  def get_all, do: @phrases

  def get_all(language) do
    @phrases
    |> Map.keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, @phrases[key][language])
    end)
  end

  @phrases
  |> Map.keys()
  |> Enum.map(fn item ->
    def unquote(item)(), do: unquote("#{item}")

    def unquote(item)(language), do: @phrases[unquote(item)][language]
  end)
end
