defmodule PhoenixTodoWeb.PageController do
  use PhoenixTodoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> put_resp_content_type("content-type", "application/json")
    |> Plug.Conn.send_resp(200, "{}")
  end
end
