defmodule AppWeb.AuthLive.Signin do
  use AppWeb, :live_view

  alias App.Account
  alias App.Account.User
  alias AppWeb.AuthLive.UserAuth

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, %{changeset: Account.change_user_registration(%User{})})
     |> assign(endpoint: socket.endpoint)}
  end

  def handle_params(unsigned_params, uri, socket) do
    IO.inspect({unsigned_params, uri, socket}, label: "handle_params")
    {:noreply, socket}
  end

  # phx-change='validate'
  def handle_event("validate", %{"user" => params} = all, socket) do
    IO.inspect(all, label: "ALL Params")
    IO.inspect(params, label: "ALL Params")

    changeset =
      %User{}
      # |> Account.change_user_registration(params)
      |> Ecto.Changeset.change()
      |> Map.put(:action, :insert)
      |> IO.inspect(label: 'validate')

    {:noreply, assign(socket, changeset: changeset)}
  end

  # phx-submit='signin'
  def handle_event("signin", %{"user" => params} = all, socket) do
    inspect(all)
    %{"email" => email, "password" => password} = params

    if user = Account.get_user_by_email_and_password(email, password) do
      {:noreply,
       socket
       |> UserAuth.signin_user(user, params)}
    else
      {:noreply,
       socket
       |> put_flash(:error, "Invalid email or password")
       |> push_redirect(to: Routes.auth_signin_path(socket.endpoint, :index))}
    end
  end
end
