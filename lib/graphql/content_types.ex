defmodule CG.GraphQL.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :account do
    field :id, :id
    field :login, :string
    field :password, :string
    field :name, :string
    field :about, :string
    field :is_admin, :boolean
    field :language, :string
    field :state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :avatar, :image
    field :background, :image
    field :recipe, list_of(:recipe)
  end

  object :category do
    field :id, :id
    field :title, :string
    field :language, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :recipe do
    field :title, :string
    field :description, :string
    field :cooking_time, :integer
    field :number_of_persons, :integer
    field :likes_count, :integer
    field :views_count, :integer
    field :language, :string
    field :state, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :author, :account
    field :categories, list_of(:category_for_recipe)
    field :steps, list_of(:recipe_step)
  end

  object :category_for_recipe do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :recipe, :recipe
    field :category, :category
  end

  object :image_for_recipe_step do
    field :id, :id
    field :preview, :boolean
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :recipe_step, :recipe_step
    field :image, :image
  end

  object :image do
    field :id, :id
    field :path, :string
    field :extension, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :product_in_unit do
    field :id, :id
    field :quantity, :float
    field :unit, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :recipe, :recipe
    field :product, :product
  end

  object :product do
    field :id, :id
    field :title, :string
    field :weight, :float
    field :language, :string
    field :unit, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :recipe_step do
    field :id, :id
    field :number, :integer
    field :title, :string
    field :description, :string
    field :optional, :boolean
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    field :recipe, :recipe
    field :attached_recipe, :recipe
  end

  object :authorization_response do
    field :session_key, :string
    field :user_id, :integer
  end
end
