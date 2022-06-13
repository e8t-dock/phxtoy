defmodule AppWeb.Api.SessionView do
  use AppWeb, :view

  def render("create.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message:
        "You are successfully logged in! Use this token to authentication heaer to make authorized requests"
    }
  end

  def render("error.json", %{message: message}) do
    %{
      status: :not_found,
      data: %{},
      message: message
    }
  end
end
