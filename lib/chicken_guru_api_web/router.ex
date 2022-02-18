defmodule CGWeb.Router do
  use CGWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    # plug CG.GraphQL.Middleware.SessionInsert
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: CG.GraphQL.Schema
    forward "/graphql", Absinthe.Plug.GraphiQL, schema: CG.GraphQL.Schema
  end
end
