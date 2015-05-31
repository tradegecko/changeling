defmodule Changeling.ChangeControllerTest do
  use Changeling.ConnCase

  alias Changeling.Change
  @valid_attrs %{change_type: "some content", full_description: "some content", issue_id: 42, short_description: "some content", technical_impact: "some content", title: "some content", visibility: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, change_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing changes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, change_path(conn, :new)
    assert html_response(conn, 200) =~ "New change"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, change_path(conn, :create), change: @valid_attrs
    assert redirected_to(conn) == change_path(conn, :index)
    assert Repo.get_by(Change, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, change_path(conn, :create), change: @invalid_attrs
    assert html_response(conn, 200) =~ "New change"
  end

  test "shows chosen resource", %{conn: conn} do
    change = Repo.insert %Change{}
    conn = get conn, change_path(conn, :show, change)
    assert html_response(conn, 200) =~ "Show change"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    change = Repo.insert %Change{}
    conn = get conn, change_path(conn, :edit, change)
    assert html_response(conn, 200) =~ "Edit change"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    change = Repo.insert %Change{}
    conn = put conn, change_path(conn, :update, change), change: @valid_attrs
    assert redirected_to(conn) == change_path(conn, :index)
    assert Repo.get_by(Change, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    change = Repo.insert %Change{}
    conn = put conn, change_path(conn, :update, change), change: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit change"
  end

  test "deletes chosen resource", %{conn: conn} do
    change = Repo.insert %Change{}
    conn = delete conn, change_path(conn, :delete, change)
    assert redirected_to(conn) == change_path(conn, :index)
    refute Repo.get(Change, change.id)
  end
end
