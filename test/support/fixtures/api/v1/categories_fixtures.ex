defmodule PhoenixTodo.Api.V1.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTodo.Api.V1.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        icon: "some icon",
        name: "some name"
      })
      |> PhoenixTodo.Api.V1.Categories.create_category()

    category
  end
end
