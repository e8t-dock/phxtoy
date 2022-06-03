defmodule AppWeb.APIReqController do
  use AppWeb, :controller

  def create(conn, params) do
    IO.inspect(params)
    text(conn, "OK")
  end

  def update(conn, params) do
    IO.inspect(params)
    text(conn, "OK")
  end
end
