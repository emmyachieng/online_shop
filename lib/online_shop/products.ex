defmodule OnlineShop.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias OnlineShop.Repo

  alias OnlineShop.Products.Catalog

  @doc """
  Returns the list of catalogs.

  ## Examples

      iex> list_catalogs()
      [%Catalog{}, ...]

  """
  def list_catalogs do
    Repo.all(Catalog)
  end

  @doc """
  Gets a single catalog.

  Raises `Ecto.NoResultsError` if the Catalog does not exist.

  ## Examples

      iex> get_catalog!(123)
      %Catalog{}

      iex> get_catalog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_catalog!(id), do: Repo.get!(Catalog, id)

  @doc """
  Creates a catalog.

  ## Examples

      iex> create_catalog(%{field: value})
      {:ok, %Catalog{}}

      iex> create_catalog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_catalog(attrs \\ %{}) do
  #   %Catalog{}
  #   |> Catalog.changeset(attrs)
  #   |> Repo.insert()
  # end

  # def create_catalog(attrs \\ %{}) do
  #   with {:ok, %Plug.Upload{path: path}} <- Map.get(attrs, :image),
  #        {:ok, binary_data} <- File.read(path) do
  #     attrs = Map.put(attrs, :image, Base.encode64(binary_data))

  #     %Catalog{}
  #     |> Catalog.changeset(attrs)
  #     |> Repo.insert()
  #   else
  #     {:error, reason} ->
  #       {:error, reason}
  #   end
  # end

  def create_catalog(attrs \\ %{}) do
    case Map.get(attrs, :image) do
      %Plug.Upload{} = uploaded_file ->
        with {:ok, binary_data} <- File.read(uploaded_file.path) do
          attrs = Map.put(attrs, :image, Base.encode64(binary_data))

          %Catalog{}
          |> Catalog.changeset(attrs)
          |> Repo.insert()
        end

      _ ->
        {:error, "No file uploaded or invalid image field"}
    end
  end

  @doc """
  Updates a catalog.

  ## Examples

      iex> update_catalog(catalog, %{field: new_value})
      {:ok, %Catalog{}}

      iex> update_catalog(catalog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_catalog(%Catalog{} = catalog, attrs) do
    catalog
    |> Catalog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a catalog.

  ## Examples

      iex> delete_catalog(catalog)
      {:ok, %Catalog{}}

      iex> delete_catalog(catalog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_catalog(%Catalog{} = catalog) do
    Repo.delete(catalog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking catalog changes.

  ## Examples

      iex> change_catalog(catalog)
      %Ecto.Changeset{data: %Catalog{}}

  """
  def change_catalog(%Catalog{} = catalog, attrs \\ %{}) do
    Catalog.changeset(catalog, attrs)
  end
end
