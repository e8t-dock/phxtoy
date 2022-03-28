defmodule AppWeb.PageLive.Index do
  use AppWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, name: "John", toggle: "off")}
  end

  @impl true
  def handle_event("toggle-change", %{"toggle" => toggle}, socket) do
    toggle = if toggle == "1", do: "on", else: "off"
    {:noreply, assign(socket, :toggle, toggle)}
  end
end
