defmodule OnlineShop.ProductsTest do
  use OnlineShop.DataCase

  alias OnlineShop.Products

  describe "catalogs" do
    alias OnlineShop.Products.Catalog
    import OnlineShop.ProductsFixtures

    @invalid_attrs %{image: nil, name: nil, price: nil}

    test "list_catalogs/0 returns all catalogs" do
      catalog = catalog_fixture()
      assert Products.list_catalogs() == [catalog]
    end

    test "get_catalog!/1 returns the catalog with given id" do
      catalog = catalog_fixture()
      assert Products.get_catalog!(catalog.id) == catalog
    end

    test "create_catalog/1 with valid data creates a catalog" do
      valid_attrs = %{image: "some image", name: "some name", price: 120.5}

      assert {:ok, %Catalog{} = catalog} = Products.create_catalog(valid_attrs)
      assert catalog.image == "some image"
      assert catalog.name == "some name"
      assert catalog.price == 120.5
    end

    test "create_catalog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_catalog(@invalid_attrs)
    end

    test "update_catalog/2 with valid data updates the catalog" do
      catalog = catalog_fixture()
      update_attrs = %{image: "some updated image", name: "some updated name", price: 456.7}

      assert {:ok, %Catalog{} = catalog} = Products.update_catalog(catalog, update_attrs)
      assert catalog.image == "some updated image"
      assert catalog.name == "some updated name"
      assert catalog.price == 456.7
    end

    test "update_catalog/2 with invalid data returns error changeset" do
      catalog = catalog_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_catalog(catalog, @invalid_attrs)
      assert catalog == Products.get_catalog!(catalog.id)
    end

    test "delete_catalog/1 deletes the catalog" do
      catalog = catalog_fixture()
      assert {:ok, %Catalog{}} = Products.delete_catalog(catalog)
      assert_raise Ecto.NoResultsError, fn -> Products.get_catalog!(catalog.id) end
    end

    test "change_catalog/1 returns a catalog changeset" do
      catalog = catalog_fixture()
      assert %Ecto.Changeset{} = Products.change_catalog(catalog)
    end
  end
end
