defmodule Changeling.ChangeTest do
  use Changeling.ModelCase

  alias Changeling.Change

  @valid_attrs %{change_type: "some content", full_description: "some content", issue_id: 42, short_description: "some content", technical_impact: "some content", title: "some content", visibility: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Change.changeset(%Change{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Change.changeset(%Change{}, @invalid_attrs)
    refute changeset.valid?
  end
end
