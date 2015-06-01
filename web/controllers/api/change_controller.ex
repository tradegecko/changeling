defmodule Changeling.Api.ChangeController do
  use Changeling.Web, :controller

  alias Changeling.Change

  plug :action

  def index(conn, _params) do
    changes = Change
    |> Change.public
    |> Repo.all
    render conn, changes: changes
  end
end
