alias CG.Service
alias CG.Service.Dump
alias CG.Repository.{Account, Recipe, CategoryForRecipe, ProductInUnit, RecipeStep}

# Заливаем в БД список продуктов
Dump.create_products_from_dump_csv("./seeds_files/products.csv")

# Заливаем в БД список категорий блюд
Dump.create_categories_from_txt("./seeds_files/categories.txt", :rus)

################################################################################
# Создаем тестовый акаунт
################################################################################
{:ok, account} =
  Service.create(Account, %{
    login: "test@test.test",
    password: "1234",
    language: :rus
  })

################################################################################
# Создаем первый тестовый рецепт
################################################################################
{:ok, recipe1} =
  Service.create(Recipe, %{
    title: "Тестовый рецепт №2",
    description: "Очень замечательный дополнение к рецепту №1",
    cooking_time: 90,
    number_of_persons: 4,
    language: :rus,
    author_id: account.id
  })

# Добавляем рецепту категории
Service.create(CategoryForRecipe, %{
  recipe_id: recipe1.id,
  category_id: 17
})

# Добавляем продукты в рецепт
Service.create(ProductInUnit, %{
  recipe_id: recipe1.id,
  product_id: 75,
  quantity: 600.0,
  unit: :gram
})

Service.create(RecipeStep, %{
  number: 1,
  title: "Замесить тест",
  description:
    "Тесто высыпать в удобную емкость, добавить соль, яйца и залить теплой водой. Вымешивать тесто до образования однородной массы",
  recipe_id: recipe1.id
})

################################################################################
# Создаем второй тестовый рецепт
################################################################################
{:ok, recipe2} =
  Service.create(Recipe, %{
    title: "Тестовый рецепт №1",
    description: "Очень замечательный тестовый рецепт по приготовлению тестовых данных",
    cooking_time: 90,
    number_of_persons: 4,
    language: :rus,
    author_id: account.id
  })

# Добавляем рецепту категории
Service.create(CategoryForRecipe, %{
  recipe_id: recipe2.id,
  category_id: 17
})

Service.create(CategoryForRecipe, %{
  recipe_id: recipe2.id,
  category_id: 25
})

# Добавляем продукты в рецепт
Service.create(ProductInUnit, %{
  recipe_id: recipe2.id,
  product_id: 75,
  quantity: 600.0,
  unit: :gram
})

Service.create(ProductInUnit, %{
  recipe_id: recipe2.id,
  product_id: 17,
  quantity: 200.0,
  unit: :milliliter
})

Service.create(ProductInUnit, %{
  recipe_id: recipe2.id,
  product_id: 145,
  quantity: 2.0,
  unit: :thing
})

Service.create(ProductInUnit, %{
  recipe_id: recipe2.id,
  product_id: 117,
  quantity: 2.0,
  unit: :gram
})

Service.create(RecipeStep, %{
  number: 1,
  title: "Замесить тест",
  description:
    "Тесто высыпать в удобную емкость, добавить соль, яйца и залить теплой водой. Вымешивать тесто до образования однородной массы",
  recipe_id: recipe2.id
})

Service.create(RecipeStep, %{
  number: 2,
  title: "Изюминка на торте",
  attached_recipe_id: recipe1.id,
  recipe_id: recipe2.id,
  optional: true
})
