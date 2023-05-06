defmodule OnlineShopWeb.PageController do
  use OnlineShopWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
