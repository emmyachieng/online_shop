defmodule OnlineShopWeb.CatalogController do
  use OnlineShopWeb, :controller

  alias OnlineShop.Products
  alias OnlineShop.Products.Catalog

  def index(conn, _params) do
    catalogs = Products.list_catalogs()
    render(conn, "index.html", catalogs: catalogs)
  end

  def new(conn, _params) do
    changeset = Products.change_catalog(%Catalog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"catalog" => catalog_params}) do
    case Products.create_catalog(catalog_params) do
      {:ok, catalog} ->
        conn
        |> put_flash(:info, "Catalog created successfully.")
        |> redirect(to: Routes.catalog_path(conn, :show, catalog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    catalog = Products.get_catalog!(id)
    render(conn, "show.html", catalog: catalog)
  end

  def edit(conn, %{"id" => id}) do
    catalog = Products.get_catalog!(id)
    changeset = Products.change_catalog(catalog)
    render(conn, "edit.html", catalog: catalog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "catalog" => catalog_params}) do
    catalog = Products.get_catalog!(id)

    case Products.update_catalog(catalog, catalog_params) do
      {:ok, catalog} ->
        conn
        |> put_flash(:info, "Catalog updated successfully.")
        |> redirect(to: Routes.catalog_path(conn, :show, catalog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", catalog: catalog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    catalog = Products.get_catalog!(id)
    {:ok, _catalog} = Products.delete_catalog(catalog)

    conn
    |> put_flash(:info, "Catalog deleted successfully.")
    |> redirect(to: Routes.catalog_path(conn, :index))
  end
end
