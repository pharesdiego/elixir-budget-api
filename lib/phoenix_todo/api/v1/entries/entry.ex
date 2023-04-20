defmodule PhoenixTodo.Api.V1.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixTodo.Api.V1.Categories
  alias PhoenixTodo.Api.V1.Accounts

  schema "entries" do
    field(:account, :string)
    field(:amount, :float)
    field(:category, :string)
    field(:date, :utc_datetime)
    field(:description, :string)

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount, :date, :description, :account, :category])
    |> validate_required([:amount, :date, :description, :account, :category])
    |> validate_length(:description, min: 2)
    |> validate_category_exists(:category)
    |> validate_account_exists(:account)
  end

  defp validate_category_exists(changeset, :category) do
    validate_change(changeset, :category, fn field, id ->
      try do
        Categories.get_category!(id)
        []
      rescue
        Ecto.NoResultsError -> [{field, "CATEGORY_DOES_NOT_EXISTS"}]
      end
    end)
  end

  defp validate_account_exists(changeset, :account) do
    validate_change(changeset, :account, fn field, id ->
      try do
        Accounts.get_account!(id)
        []
      rescue
        Ecto.NoResultsError -> [{field, "ACCOUNT_DOES_NOT_EXISTS"}]
      end
    end)
  end
end
