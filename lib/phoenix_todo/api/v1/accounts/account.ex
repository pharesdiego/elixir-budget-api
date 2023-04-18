defmodule PhoenixTodo.Api.V1.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :icon, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :icon])
    |> validate_required([:name, :icon])
  end
end
