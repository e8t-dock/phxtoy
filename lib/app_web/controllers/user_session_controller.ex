defmodule AppWeb.UserSessionController do
  use AppWeb, :controller

  alias App.Accounts
  alias AppWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    # if user = Accounts.get_user_by_email_and_password(email, password) do
    #   UserAuth.log_in_user(conn, user, user_params)
    # else
    #   # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
    #   render(conn, "new.html", error_message: "Invalid email or password")
    # end

    # v1
    with {:ok, user} <- Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      {:error, :bad_username_or_password} ->
        render(conn, "new.html", error_message: "Invalid email or password")

      {:error, :email_not_confirmed} ->
        # send confirm email
        user = Accounts.get_user_by_email(email)

        # Version Fix
        # Accounts.deliver_user_confirmation_instructions(
        #   user,
        #   &Routes.user_confirmation_url(conn, :confirm, &1)
        # )
        Accounts.deliver_user_confirmation_instructions(
          user,
          &Routes.user_confirmation_url(conn, :edit, &1)
        )

        render(conn, "new.html", error_message: error_message(:email_not_confirmed))

      {:error, :user_blocked} ->
        render(conn, "new.html", error_message: error_message(:user_blocked))
    end
  end

  def error_message(:email_not_confirmed),
    do:
      "Please confirm your email before signing in. An email confirmation link has been sent to you."

  def error_message(:bad_username_or_password), do: "Invalid email or password"

  def error_message(:user_blocked),
    do: "Your account has been locked, please contact an administrator."

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
