defmodule OnlineShop.Api do
  use Tesla

  def client(token) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", "Basic " <> token}]}
    ]

    Tesla.client(middleware)
  end

  def generate_token(token) do
    client(token)
    |> Tesla.get("/oauth/v1/generate", query: [grant_type: "client_credentials"])
  end
end
