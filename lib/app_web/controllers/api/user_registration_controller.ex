defmodule AppWeb.Api.UserRegistrationController do
  use AppWeb, :controller
  require Logger

  alias App.Accounts
  alias AppWeb.UserRegistrationController

  def create(conn, %{"user" => user_params}) do
    Logger.info(user_params)

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        # {:ok, _} =
        #   Accounts.deliver_user_confirmation_instructions(
        #     user,
        #     &Routes.user_confirmation_url(conn, :edit, &1)
        #   )

        conn
        |> render("create.json",
          email: user.email,
          message: UserRegistrationController.create_message()
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
end
