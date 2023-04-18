defmodule PhoenixTodoWeb.PageController do
  use PhoenixTodoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
      |> assign(:entries, PhoenixTodo.Api.V1.Entries.list_entries())
      |> render(:home)
  end
end
