defmodule PhoenixTodo.Api.V1.Entries do
  @moduledoc """
  The Api.V1.Entries context.
  """

  import Ecto.Query, warn: false
  alias PhoenixTodo.Repo

  alias PhoenixTodo.Api.V1.Entries.Entry
  alias PhoenixTodo.Api.V1.Categories.Category
  alias PhoenixTodo.Api.V1.Accounts.Account
  alias PhoenixTodoWeb.Api.V1.CategoryJSON
  alias PhoenixTodoWeb.Api.V1.AccountJSON

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries(params) do
    query =
      from e in Entry,
        join: cat in Category,
        on: e.category == cat.id,
        join: acc in Account,
        on: e.account == acc.id,
        select: %{e | category: cat, account: acc},
        limit: 1000,
        order_by: [desc: e.date]

    query = params
      |> Map.to_list()
      |> Enum.reduce(query, fn
        {"from", from}, query -> from e in query, where: e.date >= ^from
        {"until", until}, query -> from e in query, where: e.date <= ^until
        {"include", ["expense"]}, query -> from e in query, where: e.amount < 0.0
        {"include", ["income"]}, query -> from e in query, where: e.amount > 0.0
        _, query -> query
      end)

    Repo.all(query)
    |> Enum.map(
      &Map.merge(&1, %{
        category: CategoryJSON.show(%{category: &1.category}).data,
        account: AccountJSON.show(%{account: &1.account}).data
      })
    )
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id) do
    query = from e in Entry,
      join: cat in Category,
      on: e.category == cat.id,
      join: acc in Account,
      on: e.account == acc.id,
      select: %{e | category: cat, account: acc},
      where: e.id == ^id

    entry = Repo.one!(query)

    Map.merge(entry, %{
      category: CategoryJSON.show(%{category: entry.category}).data,
      account: AccountJSON.show(%{account: entry.account}).data
    })
  end

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end
end
