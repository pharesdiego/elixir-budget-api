defmodule PhoenixTodoWeb.Api.V1.EntryController do
  use PhoenixTodoWeb, :controller

  alias PhoenixTodo.Api.V1.Entries
  alias PhoenixTodo.Api.V1.Entries.Entry

  action_fallback PhoenixTodoWeb.FallbackController

  def index(conn, params) do
    entries = Entries.list_entries(params)
    render(conn, :index, entries: entries)
  end

  def create(conn, entry_params) do
    with {:ok, %Entry{} = entry} <- Entries.create_entry(entry_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/entries/#{entry}")
      |> render(:show, entry: entry)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    render(conn, :show, entry: entry)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Entries.get_entry!(id)

    with {:ok, %Entry{} = entry} <- Entries.update_entry(entry, entry_params) do
      render(conn, :show, entry: entry)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)

    with {:ok, %Entry{}} <- Entries.delete_entry(entry) do
      send_resp(conn, :no_content, "")
    end
  end

  def export(conn, params) do
    entries = Entries.list_entries(params)

    conn
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"export.#{get_format(conn)}\""
    )
    |> render(:index, entries: entries)
  end
end
