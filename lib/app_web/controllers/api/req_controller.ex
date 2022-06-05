defmodule AppWeb.APIReqController do
  use AppWeb, :controller

  def index(conn, params) do
    IO.inspect(params)
    # json(conn, %{message: "phx api"})
    # text(conn, "OK")
    render(conn, "index.json", message: "Phx API")
  end

  def create(conn, params) do
    IO.inspect(params)
    text(conn, "OK")
  end

  def update(conn, params) do
    IO.inspect(params)
    text(conn, "OK")
  end
end
