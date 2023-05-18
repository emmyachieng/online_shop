defmodule OnlineShopWeb.PageController do
  use OnlineShopWeb, :controller

  def index(conn, _params) do
    with {:ok, token} <- extract_token(conn),
         {:ok, %Tesla.Env{body: token}} <- OnlineShop.Api.generate_token(token) do
      json(conn, %{token: token})
    end
  end

  def extract_token(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [auth_header] ->
        get_token_from_header(auth_header)

      _ ->
        {:error, "Missing auth header"}
    end
  end

  def get_token_from_header(auth_header) do
    {:ok, reg} = Regex.compile("Basic\:?\s+(.*)$", "i")

    case Regex.run(reg, auth_header) do
      [_, match] ->
        {:ok, String.trim(match)}

      _ ->
        {:error, "Token not found"}
    end
  end
end
