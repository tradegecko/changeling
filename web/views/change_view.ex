defmodule Changeling.ChangeView do
  use Changeling.Web, :view

  def github_url(id) do
    link("##{id}", to: "https://www.github.com/tradegecko/tradegecko/pull/#{id}")
  end
end
