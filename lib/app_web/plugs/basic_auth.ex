defmodule AppWeb.Plugs.BasicAuth do
  import Plug.Conn

  @fake_auth %{
    "alice-longpassword": "user-1",
    "bob-longpassword": "user-2"
  }

  def init(default), do: default

  def call(conn, _opts) do
    IO.inspect(conn.assigns)

    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn),
         user_id = @fake_auth |> Map.get("#{user}-#{pass}") do
      IO.inspect([user, pass], label: "username and password")
      assign(conn, :current_user, user_id)
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end
end
