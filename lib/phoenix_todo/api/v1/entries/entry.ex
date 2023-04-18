defmodule PhoenixTodo.Api.V1.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :account, Ecto.UUID
    field :amount, :float
    field :category, Ecto.UUID
    field :date, :utc_datetime
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount, :date, :description, :account, :category])
    |> validate_required([:amount, :date, :description, :account, :category])
  end
end
