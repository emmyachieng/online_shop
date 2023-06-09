defmodule OnlineShopWeb.MpesaController do
  use OnlineShopWeb, :controller

  @spec get_token(Plug.Conn.t(), any) :: {:error, any} | Plug.Conn.t()
  def get_token(conn, _params) do
    with {:ok, request_token} <- get_token(conn),
         {:ok, %Tesla.Env{body: token}} <- OnlineShop.Api.generate_token("Basic #{request_token}") do
      json(conn, %{token: token})
    end
  end

  def customer_to_business(conn, params) do
    with {:ok, token} <- get_token(conn),
         {:ok, %Tesla.Env{body: register_url}} <-
           OnlineShop.Api.customer_to_business("Bearer #{token}", params) do
      json(conn, %{register_url: register_url})
    end
  end

  def transaction_status(conn, params) do
    with {:ok, token} <- get_token(conn),
         {:ok, %Tesla.Env{body: register_url}} <-
           OnlineShop.Api.transaction_status("Bearer #{token}", params) do
      json(conn, %{register_url: register_url})
    end
  end

  defp get_token(conn) do
    [token] =
      conn
      |> Plug.Conn.get_req_header("authorization")

    text = String.split(token, " ")
    {:ok, List.last(text)}
  end
end
