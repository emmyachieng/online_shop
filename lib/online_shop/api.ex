defmodule OnlineShop.Api do
  use Tesla

  def client(token) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", token}]}
    ]

    Tesla.client(middleware)
  end

  def generate_token(token) do
    client(token)
    |> Tesla.get("/oauth/v1/generate", query: [grant_type: "client_credentials"])
  end

  def customer_to_business(token, params) do
    client(token)
    |> Tesla.post("mpesa/c2b/v1/registerurl", params)
  end

  def transaction_status(token, params) do
    client(token)
    |> Tesla.post("/mpesa/transactionstatus/v1/query", params)
  end
end
