defmodule CGWeb.Router do
  use CGWeb, :router

  pipeline :session, do: plug(CGWeb.Session)

  pipeline :client do
    plug CGWeb.Middleware.SessionCheck, :client
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CGWeb do
    pipe_through :api
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
