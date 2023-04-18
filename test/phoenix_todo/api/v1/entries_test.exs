defmodule PhoenixTodo.Api.V1.EntriesTest do
  use PhoenixTodo.DataCase

  alias PhoenixTodo.Api.V1.Entries

  describe "entries" do
    alias PhoenixTodo.Api.V1.Entries.Entry

    import PhoenixTodo.Api.V1.EntriesFixtures

    @invalid_attrs %{account: nil, amount: nil, category: nil, date: nil, description: nil}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Entries.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{account: "7488a646-e31f-11e4-aace-600308960662", amount: 120.5, category: "7488a646-e31f-11e4-aace-600308960662", date: ~U[2023-04-15 15:18:00Z], description: "some description"}

      assert {:ok, %Entry{} = entry} = Entries.create_entry(valid_attrs)
      assert entry.account == "7488a646-e31f-11e4-aace-600308960662"
      assert entry.amount == 120.5
      assert entry.category == "7488a646-e31f-11e4-aace-600308960662"
      assert entry.date == ~U[2023-04-15 15:18:00Z]
      assert entry.description == "some description"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{account: "7488a646-e31f-11e4-aace-600308960668", amount: 456.7, category: "7488a646-e31f-11e4-aace-600308960668", date: ~U[2023-04-16 15:18:00Z], description: "some updated description"}

      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, update_attrs)
      assert entry.account == "7488a646-e31f-11e4-aace-600308960668"
      assert entry.amount == 456.7
      assert entry.category == "7488a646-e31f-11e4-aace-600308960668"
      assert entry.date == ~U[2023-04-16 15:18:00Z]
      assert entry.description == "some updated description"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
