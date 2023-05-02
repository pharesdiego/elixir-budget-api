defmodule PhoenixTodoWeb.Api.V1.EntryCSV do
  @doc """
  Renders a list of entries.
  """
  def index(%{entries: entries}) do
    rows = entries
    |> Enum.map(
      &Enum.join(
        [&1.amount, "\"" <> &1.description <> "\"", &1.account.name, &1.category.name, &1.date],
        ","
      )
    )
    |> Enum.join("\n")

    "amount,description,amount,category,date\n" <> rows
  end
end
