defmodule OnlineShop.Repo.Migrations.CreateCatalogs do
  use Ecto.Migration

  def change do
    create table(:catalogs) do
      add :name, :string
      add :image, :text
      add :price, :float

      timestamps()
    end
  end
end
