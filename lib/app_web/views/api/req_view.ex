defmodule AppWeb.APIReqView do
  use AppWeb, :view

  def render("index.json", %{message: message}) do
    %{message: message}
  end
end
