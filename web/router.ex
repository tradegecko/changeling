defmodule Changeling.Router do
  use Changeling.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Changeling do
    pipe_through :browser # Use the default browser stack

    get "/", ChangeController, :index
    resources "/changes", ChangeController, except: [:show, :index]
  end

  scope "/auth", Changeling do
    pipe_through :browser
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  scope "/api", Changeling.Api do
    pipe_through :api
    get "/changes", ChangeController, :index
  end

  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
