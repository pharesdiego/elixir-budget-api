defmodule PhoenixTodoWeb.EntryControllerTest do
  use PhoenixTodoWeb.ConnCase

  import PhoenixTodo.Api.V1.EntriesFixtures

  alias PhoenixTodo.Api.V1.Entries.Entry

  @create_attrs %{
    account: "7488a646-e31f-11e4-aace-600308960662",
    amount: 120.5,
    category: "7488a646-e31f-11e4-aace-600308960662",
    date: ~U[2023-04-15 15:18:00Z],
    description: "some description"
  }
  @update_attrs %{
    account: "7488a646-e31f-11e4-aace-600308960668",
    amount: 456.7,
    category: "7488a646-e31f-11e4-aace-600308960668",
    date: ~U[2023-04-16 15:18:00Z],
    description: "some updated description"
  }
  @invalid_attrs %{account: nil, amount: nil, category: nil, date: nil, description: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entries", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/entries")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entry" do
    test "renders entry when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/entries", entry: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/entries/#{id}")

      assert %{
               "id" => ^id,
               "account" => "7488a646-e31f-11e4-aace-600308960662",
               "amount" => 120.5,
               "category" => "7488a646-e31f-11e4-aace-600308960662",
               "date" => "2023-04-15T15:18:00Z",
               "description" => "some description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/entries", entry: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update entry" do
    setup [:create_entry]

    test "renders entry when data is valid", %{conn: conn, entry: %Entry{id: id} = entry} do
      conn = put(conn, ~p"/api/v1/entries/#{entry}", entry: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/entries/#{id}")

      assert %{
               "id" => ^id,
               "account" => "7488a646-e31f-11e4-aace-600308960668",
               "amount" => 456.7,
               "category" => "7488a646-e31f-11e4-aace-600308960668",
               "date" => "2023-04-16T15:18:00Z",
               "description" => "some updated description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, entry: entry} do
      conn = put(conn, ~p"/api/v1/entries/#{entry}", entry: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete entry" do
    setup [:create_entry]

    test "deletes chosen entry", %{conn: conn, entry: entry} do
      conn = delete(conn, ~p"/api/v1/entries/#{entry}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/entries/#{entry}")
      end
    end
  end

  defp create_entry(_) do
    entry = entry_fixture()
    %{entry: entry}
  end
end
