defmodule OnlineShopWeb.MpesaController do
  use OnlineShopWeb, :controller

  @spec get_token(Plug.Conn.t(), any) :: {:error, any} | Plug.Conn.t()
  def get_token(conn, _params) do
    with {:ok, %Tesla.Env{body: token}} <- OnlineShop.Mpesa.Api.generate_token() do
      json(conn, %{token: token})
    end
  end

  def customer_to_business(conn, params) do
    with {:ok, %Tesla.Env{body: register_url}} <- OnlineShop.Client.customer_to_business(params) do
      json(conn, %{register_url: register_url})
    end
  end

  def transaction_status(conn, params) do
    with {:ok, %Tesla.Env{body: status}} <- OnlineShop.Client.transaction_status(params) do
      json(conn, %{status: status})
    end
  end
end
