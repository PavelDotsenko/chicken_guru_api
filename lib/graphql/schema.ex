defmodule CG.GraphQL.Schema do
  use Absinthe.Schema

  import_types(CG.GraphQL.Schema.ContentTypes)
  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)

  # alias CG.GraphQL.Middleware.UserCheck

  # alias CG.GraphQL.{AccountResolver, FileResolver}

  query do
    # @desc "Авторизация пользователя"
    # field :user_authorization, :authorization_response do
    #   arg(:login, non_null(:string))
    #   arg(:password, non_null(:string))

    #   resolve(&AccountResolver.authorization/3)
    # end

    # @desc "Авторизация пользователя"
    # field :user_info, :user do
    #   arg(:user_id, non_null(:integer))

    #   middleware(UserCheck)
    #   resolve(&AccountResolver.get_info/3)
    # end
  end

  # mutation do
  #   # @desc "Регистрация нового пользователя"
  #   # field :registration_user, :message do
  #   #   arg(:login, non_null(:string))
  #   #   arg(:name, non_null(:string))
  #   #   arg(:password, non_null(:string))
  #   #   arg(:language, non_null(:string))

  #   #   resolve(&AccountResolver.registration/3)
  #   # end

  #   # @desc "Загрузка изображения на сервер"
  #   # field :upload_file, :message do
  #   #   arg :file_data, non_null(:upload)

  #   #   resolve(&FileResolver.upload/3)
  #   # end
  # end
end

# %Plug.Upload{
#   content_type: "image/jpeg",
#   filename: "1234.jpg",
#   path: "/tmp/plug-1634/multipart-1634746743-515766415611620-5"
# }
