defmodule AppWeb.LoginEmail do
  @moduledoc false

  use Phoenix.Swoosh,
    view: AppWeb.EmailView,
    layout: {AppWeb.LayoutView, :email}

  def login_email(user) do
    new()
    |> to(user.email)
    |> from({"App", "app@example.com"})
    |> subject("Login Link")
    |> render_body("login_email.html", %{})
  end
end
