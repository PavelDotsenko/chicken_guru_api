defmodule CGWeb.Router do
  use CGWeb, :router

  pipeline :session, do: plug(CGWeb.Session)

  pipeline :client do
    plug CGWeb.Middleware.SessionCheck, :client
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", CGWeb.Controller do
    pipe_through :api

    scope "/account" do
      post "/", AccountController, :create
    end

    scope "/control" do
      scope "/language" do
        post "/", LanguageController, :create
        get "/", LanguageController, :list
        patch "/", LanguageController, :update
        delete "/", LanguageController, :delete
      end

      scope "/category" do
        post "/", CategoryController, :create
        get "/", CategoryController, :list
        patch "/", CategoryController, :update
        delete "/", CategoryController, :delete
      end
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
