defmodule OnlineShop.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OnlineShop.Products` context.
  """

  @doc """
  Generate a catalog.
  """
  def catalog_fixture(attrs \\ %{}) do
    {:ok, catalog} =
      attrs
      |> Enum.into(%{
        image: "some image",
        name: "some name",
        price: 120.5
      })
      |> OnlineShop.Products.create_catalog()

    catalog
  end
end
