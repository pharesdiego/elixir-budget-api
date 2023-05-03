defmodule PhoenixTodoWeb.Router do
  use PhoenixTodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixTodoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "csv"]
  end

  scope "/", PhoenixTodoWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", PhoenixTodoWeb do
    pipe_through :api

    scope "/v1", Api.V1 do
      resources "/entries", EntryController, except: [:new, :edit]
      resources "/categories", CategoryController, except: [:new, :edit]
      resources "/accounts", AccountController, except: [:new, :edit]
      get "/export", EntryController, :export
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenix_todo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixTodoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
