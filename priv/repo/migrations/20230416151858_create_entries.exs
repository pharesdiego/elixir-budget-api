defmodule PhoenixTodo.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount, :float
      add :date, :utc_datetime
      add :description, :string
      add :account, :string
      add :category, :string

      timestamps()
    end
  end
end
