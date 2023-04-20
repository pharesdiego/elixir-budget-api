# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixTodo.Repo.insert!(%PhoenixTodo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule SeedCategories do
  alias PhoenixTodo.Api.V1.Categories
  alias PhoenixTodo.Api.V1.Categories.Category
  alias PhoenixTodo.Repo

  @categories [
    %{
      icon: "camera",
      name: "Photography"
    },
    %{
      icon: "globe-asia-australia",
      name: "Travel"
    },
    %{
      icon: "language",
      name: "Language course"
    },
    %{
      icon: "gift",
      name: "Gifts"
    }
  ]

  def generate do
    Repo.delete_all(Category)

    @categories |> Enum.each(&Categories.create_category(&1))
  end
end

SeedCategories.generate()

defmodule SeedAccounts do
  alias PhoenixTodo.Api.V1.Accounts
  alias PhoenixTodo.Api.V1.Accounts.Account
  alias PhoenixTodo.Repo

  @accounts [
    %{
      icon: "chart-bar",
      name: "Investments"
    },
    %{
      icon: "credit-card",
      name: "Credit card"
    },
    %{
      icon: "currency-dollars",
      name: "Savings"
    }
  ]

  def generate do
    Repo.delete_all(Account)

    @accounts |> Enum.each(&Accounts.create_account(&1))
  end
end

SeedAccounts.generate()

defmodule SeedEntries do
  alias PhoenixTodo.Api.V1.Accounts
  alias PhoenixTodo.Api.V1.Accounts.Account
  alias PhoenixTodo.Api.V1.Categories
  alias PhoenixTodo.Api.V1.Categories.Category
  alias PhoenixTodo.Api.V1.Entries
  alias PhoenixTodo.Api.V1.Entries.Entry
  alias PhoenixTodo.Repo
  import Ecto.Query

  def generate do
    Repo.delete_all(Entry)
    categories = Repo.all(Category) |> Enum.map(& &1.id)
    accounts = Repo.all(Account) |> Enum.map(& &1.id)

    for _ <- 0..99 do
      %{
        date:
          Faker.DateTime.between(
            DateTime.add(DateTime.utc_now(), -100, :day),
            DateTime.add(DateTime.utc_now(), 100, :day)
          ),
        amount: :random.uniform(100000) / 100 * Enum.random([1, -1]),
        description: Faker.Lorem.paragraph(1..3),
        category: Integer.to_string(Enum.random(categories)),
        account: Integer.to_string(Enum.random(accounts))
      }
    end |> Enum.each(&Entries.create_entry(&1))
  end
end

SeedEntries.generate()
