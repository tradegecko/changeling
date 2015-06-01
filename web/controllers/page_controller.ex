defmodule Changeling.PageController do
  use Changeling.Web, :controller

  plug :ensure_no_user!
  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  # Redirect to Index page if logged in
  defp ensure_no_user!(conn, params) do
    if get_session(conn, :current_user) do
      conn
      |> redirect(to: change_path(conn, :index))
    else
      conn
    end
  end
end
