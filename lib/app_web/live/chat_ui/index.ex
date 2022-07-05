defmodule AppWeb.ChatUILive.Index do
  use AppWeb, :live_view

  # alias App.Accounts
  # alias App.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Chat UI")}
  end
end
