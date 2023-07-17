defmodule OnlineShopWeb.CatalogControllerTest do
  use OnlineShopWeb.ConnCase

  import OnlineShop.ProductsFixtures

  @create_attrs %{image: "some image", name: "some name", price: 120.5}
  @update_attrs %{image: "some updated image", name: "some updated name", price: 456.7}
  @invalid_attrs %{image: nil, name: nil, price: nil}

  describe "index" do
    test "lists all catalogs", %{conn: conn} do
      conn = get(conn, Routes.catalog_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Catalogs"
    end
  end

  describe "new catalog" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.catalog_path(conn, :new))
      assert html_response(conn, 200) =~ "New Catalog"
    end
  end

  describe "create catalog" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.catalog_path(conn, :create), catalog: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.catalog_path(conn, :show, id)

      conn = get(conn, Routes.catalog_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Catalog"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.catalog_path(conn, :create), catalog: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Catalog"
    end
  end

  describe "edit catalog" do
    setup [:create_catalog]

    test "renders form for editing chosen catalog", %{conn: conn, catalog: catalog} do
      conn = get(conn, Routes.catalog_path(conn, :edit, catalog))
      assert html_response(conn, 200) =~ "Edit Catalog"
    end
  end

  describe "update catalog" do
    setup [:create_catalog]

    test "redirects when data is valid", %{conn: conn, catalog: catalog} do
      conn = put(conn, Routes.catalog_path(conn, :update, catalog), catalog: @update_attrs)
      assert redirected_to(conn) == Routes.catalog_path(conn, :show, catalog)

      conn = get(conn, Routes.catalog_path(conn, :show, catalog))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, catalog: catalog} do
      conn = put(conn, Routes.catalog_path(conn, :update, catalog), catalog: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Catalog"
    end
  end

  describe "delete catalog" do
    setup [:create_catalog]

    test "deletes chosen catalog", %{conn: conn, catalog: catalog} do
      conn = delete(conn, Routes.catalog_path(conn, :delete, catalog))
      assert redirected_to(conn) == Routes.catalog_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.catalog_path(conn, :show, catalog))
      end
    end
  end

  defp create_catalog(_) do
    catalog = catalog_fixture()
    %{catalog: catalog}
  end
end
