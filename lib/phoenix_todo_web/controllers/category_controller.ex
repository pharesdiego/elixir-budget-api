defmodule PhoenixTodoWeb.Api.V1.CategoryController do
  use PhoenixTodoWeb, :controller

  alias PhoenixTodo.Api.V1.Categories
  alias PhoenixTodo.Api.V1.Categories.Category

  action_fallback PhoenixTodoWeb.FallbackController

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end

  def create(conn, category_params) do
    with {:ok, %Category{} = category} <- Categories.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/categories/#{category}")
      |> render(:show, category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, :show, category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    with {:ok, %Category{} = category} <- Categories.update_category(category, category_params) do
      render(conn, :show, category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)

    with {:ok, %Category{}} <- Categories.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
