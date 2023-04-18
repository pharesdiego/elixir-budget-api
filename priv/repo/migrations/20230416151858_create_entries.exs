defmodule PhoenixTodo.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount, :float
      add :date, :utc_datetime
      add :description, :string
      add :account, :uuid
      add :category, :uuid

      timestamps()
    end
  end
end
