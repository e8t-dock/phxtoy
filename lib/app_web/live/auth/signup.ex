defmodule AppWeb.AuthLive.Signup do
  use AppWeb, :live_view

  alias App.Account
  alias App.Account.User

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, %{changeset: Account.change_user_registration(%User{})})
     |> assign(endpoint: socket.endpoint)}
  end

  def handle_event("validate", %{"user" => params} = all, socket) do
    IO.inspect(all, label: "ALL Params")

    changeset =
      %User{}
      |> Account.change_user_registration(params)
      |> IO.inspect(label: 'validate')
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("signup", %{"user" => params} = all, socket) do
    IO.inspect(all, label: "ALL Params siginup")
    IO.inspect(socket.endpoint, label: "siginup")

    case Account.register_user(params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User Registered. Sign in please.")
         |> push_redirect(to: Routes.auth_signin_path(socket.endpoint, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end

    # {:noreply, socket}
  end
end
