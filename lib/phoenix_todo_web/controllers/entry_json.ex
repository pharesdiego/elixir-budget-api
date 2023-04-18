defmodule PhoenixTodoWeb.Api.V1.EntryJSON do
  alias PhoenixTodo.Api.V1.Entries.Entry

  @doc """
  Renders a list of entries.
  """
  def index(%{entries: entries}) do
    %{data: for(entry <- entries, do: data(entry))}
  end

  @doc """
  Renders a single entry.
  """
  def show(%{entry: entry}) do
    %{data: data(entry)}
  end

  defp data(%Entry{} = entry) do
    %{
      id: entry.id,
      amount: entry.amount,
      date: entry.date,
      description: entry.description,
      account: entry.account,
      category: entry.category
    }
  end
end
