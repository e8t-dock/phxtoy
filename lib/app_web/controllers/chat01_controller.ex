defmodule AppWeb.Chat01Controller do
  use AppWeb, :controller

  def index(conn, params) do
    IO.inspect(params)
    render(conn, "index.html")
  end
end
