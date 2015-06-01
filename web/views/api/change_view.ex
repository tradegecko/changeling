defmodule Changeling.Api.ChangeView do
  use Changeling.Web, :view

  def render("index.json", %{changes: changes}) do
    changes
  end
end
