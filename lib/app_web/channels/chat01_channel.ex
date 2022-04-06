defmodule AppWeb.Chat01Channel do
  use Phoenix.Channel

  # anyone can join chat01 lobby
  def join("chat01:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("chat01:" <> private_chat_id, params, socket) do
    IO.inspect(private_chat_id, label: "private_chat")
    IO.inspect(params, label: "private_chat")
    {:ok, socket}
    # {:error, %{reason: "unauthorized"}}
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
