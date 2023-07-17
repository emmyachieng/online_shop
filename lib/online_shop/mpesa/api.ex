defmodule OnlineShop.Mpesa.Api do
  use Tesla

  @adapter Tesla.Adapter.Hackney
  @system_env_basic_auth "S0l4aDN6U1ZEM1NMODRFRk5aU3c3RTUxcWpOZFhHcDA6V0tzbkRYdmwwVWNicU5sZQ"

  def client_generate_token(endpoint, token_type) when is_atom(token_type) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Opts, [endpoint: endpoint]},
      {Tesla.Middleware.Headers,
       [{"Content-Type", "application/json"}] ++ auth_header(token_type)}
    ]

    Tesla.client(middleware, @adapter)
  end

  def generate_token() do
    "generate_token"
    |> OnlineShop.Mpesa.Api.client_generate_token(:basic_token)
    |> Tesla.get("/oauth/v1/generate?grant_type=client_credentials")
  end

  def auth_header(:basic_token) do
    [{"Authorization", "Basic #{@system_env_basic_auth}"}]
  end

  def auth_header(:bearer_token) do
    {:ok, %Tesla.Env{body: %{"access_token" => token}}} = generate_token()
    [{"Authorization", "Bearer #{token}"}]
  end
end
