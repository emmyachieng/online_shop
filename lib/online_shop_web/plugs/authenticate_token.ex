defmodule OnlineShopWeb.Plugs.AuthenticateToken do
  def init(opts), do: opts

  def call(conn, _opts) do
    token = get_token(conn)

    case token do
      nil -> conn |> Plug.Conn.send_resp(404, "Token not found") |> Plug.Conn.halt()
      _ -> conn
    end
  end

  defp get_token(conn) do
    [token] =
      conn
      |> Plug.Conn.get_req_header("authorization")

    text = String.split(token, " ")
    List.last(text)
  end
end
