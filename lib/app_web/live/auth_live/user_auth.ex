defmodule AppWeb.AuthLive.UserAuth do
  import Phoenix.LiveView

  alias App.Account
  alias AppWeb.Router.Helpers, as: Routes

  def on_mount(scope, _params, session, socket) do
    IO.inspect({scope, session, socket}, label: "on_mount")

    case socket.assigns |> Map.get(:current_user) do
      nil ->
        user_token = socket.assigns |> Map.get(:user_token, nil)
        user = user_token && Account.get_user_by_session_token(user_token)

        if scope == :require_user and is_nil(user) do
          {:halt, push_redirect(socket, to: Routes.auth_signin_path(socket.endpoint, :index))}
        else
          {:cont, socket |> assign(current_user: user)}
        end

      user ->
        IO.inspect(user)
        {:cont, socket}
    end
  end

  def signin_user(socket, user, params \\ %{}) do
    inspect(params)
    token = Account.generate_user_session_token(user)
    # user_return_to = get_session(conn, :user_return_to)

    socket
    |> assign(user_token: token)
    |> put_flash(:info, "User Signed in")
    |> push_redirect(to: Routes.product_index_path(socket.endpoint, :index))

    # |> renew_session()
    # |> put_session(:user_token, token)
    # |> put_session(:live_socket_id, "users_sessions:#{Base.url_encode64(token)}")
    # |> maybe_write_remember_me_cookie(token, params)
    # |> redirect(to: user_return_to || signed_in_path(conn))
  end

  # @doc """
  # Authenticates the user by looking into the session
  # and remember me token.
  # """
  # def fetch_current_user(conn, _opts) do
  #   {user_token, conn} = ensure_user_token(conn)
  #   user = user_token && Account.get_user_by_session_token(user_token)
  #   assign(conn, :current_user, user)
  # end

  # defp ensure_user_token(conn) do
  #   if user_token = get_session(conn, :user_token) do
  #     {user_token, conn}
  #   else
  #     conn = fetch_cookies(conn, signed: [@remember_me_cookie])

  #     if user_token = conn.cookies[@remember_me_cookie] do
  #       {user_token, put_session(conn, :user_token, user_token)}
  #     else
  #       {nil, conn}
  #     end
  #   end
  # end
end
