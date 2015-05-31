defmodule Changeling.ChangeController do
  use Changeling.Web, :controller

  alias Changeling.Change

  plug :scrub_params, "change" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    changes = Repo.all(Change)
    render(conn, "index.html", changes: changes)
  end

  def new(conn, _params) do
    changeset = Change.changeset(%Change{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"change" => change_params}) do
    changeset = Change.changeset(%Change{}, change_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Change created successfully.")
      |> redirect(to: change_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    change = Repo.get(Change, id)
    render(conn, "show.html", change: change)
  end

  def edit(conn, %{"id" => id}) do
    change = Repo.get(Change, id)
    changeset = Change.changeset(change)
    render(conn, "edit.html", change: change, changeset: changeset)
  end

  def update(conn, %{"id" => id, "change" => change_params}) do
    change = Repo.get(Change, id)
    changeset = Change.changeset(change, change_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Change updated successfully.")
      |> redirect(to: change_path(conn, :index))
    else
      render(conn, "edit.html", change: change, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    change = Repo.get(Change, id)
    Repo.delete(change)

    conn
    |> put_flash(:info, "Change deleted successfully.")
    |> redirect(to: change_path(conn, :index))
  end
end
