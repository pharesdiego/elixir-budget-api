defmodule PhoenixTodo.Api.V1.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTodo.Api.V1.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        icon: "some icon",
        name: "some name"
      })
      |> PhoenixTodo.Api.V1.Accounts.create_account()

    account
  end
end
