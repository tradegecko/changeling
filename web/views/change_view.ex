defmodule Changeling.ChangeView do
  use Changeling.Web, :view

  def github_url(id) do
    link("##{id}", to: "https://www.github.com/tradegecko/tradegecko/pull/#{id}")
  end

  def truncate(string, length \\ 25) do
    if String.length(string) > length do
      string
      String.slice(string, 0, length) <> "..."
    else
      string
    end
  end
end
