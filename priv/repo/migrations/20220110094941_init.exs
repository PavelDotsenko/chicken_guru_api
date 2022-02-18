defmodule CG.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    CG.Types.AccountState.create_type()
    CG.Types.LanguageType.create_type()
    CG.Types.UnitType.create_type()
    CG.Types.RecipeType.create_type()

    # Для добавления нового значения для типа
    # нужно создать файл миграции и функции change написать следующую строку
    # Ecto.Migration.execute "ALTER TYPE НАЗВАНИЕ_ТИПА ADD VALUE IF NOT EXISTS 'НОВОЕ_ЗНАЧЕНИЕ'"
  end
end
