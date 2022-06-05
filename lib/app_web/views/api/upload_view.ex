defmodule AppWeb.APIUploadView do
  use AppWeb, :view

  def render("api_error.json", %{reason: reason}) do
    %{
      status: "failed",
      message: inspect(reason)
    }
  end

  def render("api_done.json", %{}) do
    %{
      status: "ok"
    }
  end

  def render("show.json", %{}) do
    %{
      status: "ok"
    }
  end
end
