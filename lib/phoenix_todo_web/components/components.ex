defmodule PhoenixTodoWeb.Components do
  use Phoenix.Component

  def list_item(assigns) do
    ~H"""
    <% is_expense? = @entry.amount < 0 %>
    <li class="flex h-16 mb-6 border-b-2 border-solid border-white">
      <div class="flex w-full my-auto h-12 text-white gap-2">
        <div class="basis-[2.813rem] shrink-0">
          <p class="body text-center">
            12 DEC
          </p>
        </div>
        <div class="grow overflow-auto">
          <p class="body mb-1">
            Food
          </p>
          <p class="text-neutral1 body2 truncate">
            <%= @entry.description %>
          </p>
        </div>
        <div class="m-auto">
          <span class={"body " <> if is_expense?, do: "text-red", else: "text-green"}>
            <%= if(is_expense?, do: "-", else: "+") <> "$#{abs(@entry.amount)}" %>
          </span>
        </div>
      </div>
    </li>
    """
  end
end
