defmodule AppWeb.Chat01Channel do
  use Phoenix.Channel
  alias AppWeb.Presence

  # anyone can join chat01 lobby
  # def join("chat01:lobby", _message, socket) do
  def join("chat01:lobby", %{"name" => name} = message, socket) do
    # {:ok, socket}
    IO.inspect(message, label: "lobby room")
    send(self(), :after_join)
    {:ok, assign(socket, :name, name)}
  end

  def join("chat01:" <> private_chat_id, params, socket) do
    IO.inspect(private_chat_id, label: "private_chat")
    IO.inspect(params, label: "private_chat")
    {:ok, socket}
    # {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:after_join, socket) do
    IO.inspect(socket.assigns)

    {:ok, track} =
      Presence.track(socket, socket.assigns.name, %{
        online_at: inspect(System.system_time(:second))
      })

    IO.inspect(track, label: "presence_track")

    push(socket, "presence_state", Presence.list(socket))
    IO.inspect(Presence.list(socket), label: "presence_list")
    {:noreply, socket}
  end

  # join 
  # terminate 
  # handle_in 
  # handle_out

  def handle_in("new_msg", %{"body" => body}, socket) do
    # notify all joined clients on this socket/topic and invoke
    # their handle_out/3 callback
    IO.puts(body)
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_out(event, payload, socket) do
    IO.inspect([event, payload], label: "handle_out")
    {:noreply, socket}
  end
end
