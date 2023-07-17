defmodule OnlineShop.Client do
  def transaction_status(params) do
    "transaction_status"
    |> OnlineShop.Mpesa.Api.client_generate_token(:bearer_token)
    |> Tesla.post("/mpesa/transactionstatus/v1/query", params)
  end

  def customer_to_business(params) do
    "customer_to_business"
    |> OnlineShop.Mpesa.Api.client_generate_token(:bearer_token)
    |> Tesla.post("/mpesa/c2b/v1/registerurl", params)
  end
end
