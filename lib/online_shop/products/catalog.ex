defmodule OnlineShop.Products.Catalog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalogs" do
    field :name, :string
    field :image, :string
    field :price, :float

    timestamps()
  end

  @doc false
  def changeset(catalog, attrs) do
    catalog
    |> cast(attrs, [:name, :image, :price])
    |> validate_required([:name, :image, :price])
  end
end
