defmodule PhoenixTodoWeb.HomeLive do
  use PhoenixTodoWeb, :live_view
  alias PhoenixTodo.Api.V1.Entries
  import PhoenixTodoWeb.Components

  def mount(_params, _session, socket) do
    entries = Entries.list_entries()

    {:ok, assign(socket, %{entries: entries})}
  end

  def handle_event("new_entry", _params, socket) do
    {:ok, _} =
      Entries.create_entry(%{
        account: "5f9ff6b5-cf38-4b73-9f37-f8dd1d2969e6",
        amount: :rand.uniform(100),
        category: "5f9ff6b5-cf38-4b73-9f37-f8dd1d2969e6",
        date: "2023-04-17T00:39:41Z",
        description:
          "created by clicking on a binding" |> String.split("") |> Enum.shuffle() |> Enum.join()
      })

    entries = Entries.list_entries()

    {:noreply, assign(socket, %{entries: entries})}
  end
end
