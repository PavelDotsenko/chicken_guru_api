defmodule CG.Repository.Recipe.Db do
  import Ecto.Query, only: [from: 2]

  alias CG.Repo

  alias CG.Repository.{
    Recipe,
    RecipeStep
  }

  def get_card_list(language) do
    recipe_card_query(language)
    |> Repo.all()
  end

  def get_info(recipe_id) do
    recipe_info_query(recipe_id)
    |> Repo.one()
    |> case do
      nil ->
        nil

      %Recipe{steps: steps} = recipe ->
        Enum.reduce(0..(Enum.count(steps) - 1), recipe, fn num, acc ->
          %RecipeStep{attached_recipe_id: attached_recipe_id} = step = Enum.at(steps, num)

          if is_nil(attached_recipe_id) do
            acc
          else
            new_step = %RecipeStep{step | attached_recipe: get_info(attached_recipe_id)}

            %Recipe{acc | steps: List.replace_at(acc.steps, num, new_step)}
          end
        end)
    end
  end

  def recipe_info_query(recipe_id) do
    from(
      r in Recipe,
      where: r.id == ^recipe_id,
      preload: [
        :steps,
        categories: [:category],
        products: [:product],
        author: [:avatar]
      ],
      select: r
    )
  end

  def recipe_card_query(language) do
    from(
      r in Recipe,
      preload: [
        categories: [:category],
        products: [:product],
        author: [:avatar]
      ],
      order_by: [desc: r.likes_count, desc: r.views_count],
      where: r.language == ^language,
      limit: 50,
      select: r
    )
  end
end
