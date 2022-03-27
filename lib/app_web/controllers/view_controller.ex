defmodule AppWeb.ViewController do
  use AppWeb, :controller

  def alpine(conn, _params) do
    render(conn, "alpine.html")
  end

  def tailwind(conn, _params) do
    render(conn, "tailwind.html")
  end
end
