defmodule AppWeb.Api.SessionController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.User
  alias App.Guardian

  def create(conn, %{"email" => nil}) do
    conn
    |> put_status(401)
    |> render("error.json", message: "User could not be authenticated [Missing user email]")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.get_user_by_email_and_password(email, password) do
      {:ok, %User{} = user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, %{})

        conn
        |> render("create.json", user: user, jwt: jwt)

      {:error, reason} ->
        conn
        |> put_status(401)
        |> render("error.json",
          # message: "User could not be authenticated [Email and Password not matched]"
          message: "User could not be authenticated [#{inspect(reason)}]"
        )
    end
  end
end
