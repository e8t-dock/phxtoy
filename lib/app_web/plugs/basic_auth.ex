defmodule AppWeb.Plugs.BasicAuth do
  import Plug.Conn

  @fake_auth %{
    "alice-longpassword" => "user-1",
    "bob-longpassword" => "user-2"
  }

  def init(default), do: default

  def call(conn, _opts) do
    IO.inspect(conn.assigns)
    # conn = handle_token(conn)

    # conn =
    #   with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn) |> IO.inspect(label: "user") do
    #     if user == "log" and pass == "out" do
    #       delete_req_header(conn, "authorization")
    #     else
    #       conn
    #     end
    #   else
    #     _ -> conn
    #   end

    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn) |> IO.inspect(label: "user"),
         # %User{} = user <- get_user()
         {:ok, user_id} <- get_user(user, pass) do
      IO.inspect(user_id, label: "user id")

      assign(conn, :current_user, user_id)

      # if user_id do
      #   assign(conn, :current_user, user_id)
      # else
      #   conn
      # end
      # |> IO.inspect(label: "after basic auth")
    else
      _ ->
        IO.inspect(get_req_header(conn, "authorization"), label: "after")

        conn
        |> Plug.BasicAuth.request_basic_auth()
        |> halt()
    end
  end

  # defp handle_token(conn) do
  #   IO.inspect(get_req_header(conn, "failed_authorization"))
  #   failed_token = get_req_header(conn, "failed_authorization")
  #   token = get_req_header(conn, "authorization")

  #   if failed_token == token do
  #     delete_req_header(conn, "authorization")
  #   end
  # end

  defp get_user(user, pass) do
    case Map.get(@fake_auth, "#{user}-#{pass}") do
      nil -> {:error, nil}
      user -> {:ok, user}
    end
  end

  # logout:
  # wido
end
