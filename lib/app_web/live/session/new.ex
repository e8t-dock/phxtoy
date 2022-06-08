defmodule AppWeb.SessionLive.New do
  use AppWeb, :live_view

  alias App.Accounts
  alias App.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    changeset = User.changeset(%User{}, %{})

    {:ok,
     socket
     |> assign(:changeset, changeset)}
  end

  # <%= f = form_for :login, "#", id: "login-form", phx_submit: "login" %>
  # </form>

  @impl true
  def handle_event("login", %{"user" => %{"email" => email}} = params, socket) do
    IO.inspect(params)

    # case Accounts.get_user_by_email(email: email) do
    socket =
      case Accounts.get_user_by_email(email) do
        nil ->
          socket
          |> put_flash(:error, "You need to create an account first")
          # to register
          # |> push_redirect(to: Routes.user_new_path(socket, :new))
          |> push_redirect(to: Routes.user_index_path(socket, :new))

        user ->
          Accounts.deliver_login_email(user)

          socket
          |> put_flash(:info, "Login email sent")
          # |> push_redirect(to: socket.assigns.return_to)
          |> push_redirect(to: Routes.user_index_path(socket, :index))
      end

    {:noreply, socket}
  end

  # @impl true
  # def handle_event("validate", %{"login" => %{"email" => email}}, socket) do
  #   {:noreply, socket}
  # end
end
