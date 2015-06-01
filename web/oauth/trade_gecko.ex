defmodule TradeGecko do
  @moduledoc """
  An OAuth2 strategy for TradeGecko.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  # Public API

  def new do
    site = System.get_env("SITE") || "https://api.tradegecko.com"
    OAuth2.new([
      strategy:      __MODULE__,
      client_id:     System.get_env("CLIENT_ID"),
      client_secret: System.get_env("CLIENT_SECRET"),
      redirect_uri:  System.get_env("REDIRECT_URI"),
      site:          site,
      authorize_url: "#{site}/oauth/authorize",
      token_url:     "#{site}/oauth/token"
    ])
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(new(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
