defmodule Changeling.Router do
  use Changeling.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Changeling do
    pipe_through :browser # Use the default browser stack

    get "/", ChangeController, :index
    resources "/changes", ChangeController, except: [:show, :index]
  end

  # Other scopes may use custom stacks.
  scope "/api", Changeling.Api do
    pipe_through :api
    get "/changes", ChangeController, :index
  end
end
