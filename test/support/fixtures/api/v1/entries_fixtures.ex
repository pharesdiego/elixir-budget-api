defmodule PhoenixTodo.Api.V1.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTodo.Api.V1.Entries` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        account: "7488a646-e31f-11e4-aace-600308960662",
        amount: 120.5,
        category: "7488a646-e31f-11e4-aace-600308960662",
        date: ~U[2023-04-15 15:18:00Z],
        description: "some description"
      })
      |> PhoenixTodo.Api.V1.Entries.create_entry()

    entry
  end
end
