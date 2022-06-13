defmodule AppWeb.Api.UserRegistrationView do
  use AppWeb, :view

  def render("create.json", %{message: message, email: email}) do
    %{
      status: :ok,
      data: %{
        email: email
      },
      message: message
    }
  end

  def render("error.json", %{changeset: changeset}) do
    message =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    %{
      status: :failed,
      data: %{},
      message: message
    }
  end
end
