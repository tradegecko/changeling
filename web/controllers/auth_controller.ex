defmodule Changeling.AuthController do
  use Changeling.Web, :controller
  alias Changeling.User

  plug :action

  @doc """
  This action is reached via `/auth` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
    redirect conn, external: TradeGecko.authorize_url!
  end

  @doc """
  This action is reached via `/auth/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    # Exchange an auth code for an access token
    token = TradeGecko.get_token!(code: code)

    # Request the user's data with the access token
    user_params = OAuth2.AccessToken.get!(token, "/users/current")

    if User.authenticate(user_params) do
      # Store the user in the session under `:current_user` and redirect to /.
      # In most cases, we'd probably just store the user's ID that can be used
      # to fetch from the database. In this case, since this example app has no
      # database, I'm just storing the user map.
      #
      # If you need to make additional resource requests, you may want to store
      # the access token as well.
      conn
      |> put_session(:current_user, user_params["user"])
      |> put_session(:access_token, token.access_token)
      |> redirect(to: change_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Access Denied.")
      |> redirect(to: "/")
    end
  end
end
