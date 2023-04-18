defmodule PhoenixTodoWeb.CategoryControllerTest do
  use PhoenixTodoWeb.ConnCase

  import PhoenixTodo.Api.V1.CategoriesFixtures

  alias PhoenixTodo.Api.V1.Categories.Category

  @create_attrs %{
    icon: "some icon",
    name: "some name"
  }
  @update_attrs %{
    icon: "some updated icon",
    name: "some updated name"
  }
  @invalid_attrs %{icon: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/categories")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create category" do
    test "renders category when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/categories", category: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/categories/#{id}")

      assert %{
               "id" => ^id,
               "icon" => "some icon",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/categories", category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update category" do
    setup [:create_category]

    test "renders category when data is valid", %{conn: conn, category: %Category{id: id} = category} do
      conn = put(conn, ~p"/api/v1/categories/#{category}", category: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/categories/#{id}")

      assert %{
               "id" => ^id,
               "icon" => "some updated icon",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, category: category} do
      conn = put(conn, ~p"/api/v1/categories/#{category}", category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete category" do
    setup [:create_category]

    test "deletes chosen category", %{conn: conn, category: category} do
      conn = delete(conn, ~p"/api/v1/categories/#{category}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/categories/#{category}")
      end
    end
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end
end
