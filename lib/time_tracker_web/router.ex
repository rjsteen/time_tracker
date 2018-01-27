defmodule TimeTrackerWeb.Router do
  use TimeTrackerWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimeTrackerWeb do
    pipe_through :browser # Use the default browser stack

  end

  scope "/", TimeTrackerWeb do
    pipe_through :protected

    get "/", PageController, :index
    resources "/customers", CustomerController
    resources "/projects", ProjectController
    resources "/tasks", TaskController
    resources "/timers", TimerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimeTrackerWeb do
  #   pipe_through :api
  # end
end
