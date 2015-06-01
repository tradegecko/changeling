defmodule Changeling.User do
  def authenticate(params) do
    user_params = params["user"]
    user_params["account_id"] == 4 && String.ends_with?(user_params["email"], "@tradegecko.com")
  end
end
