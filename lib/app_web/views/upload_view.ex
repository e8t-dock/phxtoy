defmodule AppWeb.UploadView do
  use AppWeb, :view

  # <%= form_for @conn, Routes.upload_path(@conn, :create),
  # [multipart: true], fn f -> %>
  # <%= file_input f, :upload, class: "form-control" %>
  # <%= submit "Upload", class: "btn btn-primary" %>
  # <% end %>

  def render("new.html", %{}) do
    {_, tag} = Phoenix.HTML.Tag.csrf_input_tag("/upload")

    tag =
      tag
      |> List.flatten()
      |> Enum.map(fn
        token when is_integer(token) -> [token] |> List.to_string()
        token -> token
      end)
      |> Enum.join()

    ~s(
     <form action="/upload" enctype="multipart/form-data" method="post">
     #{tag}
<input class="form-control" id="upload" name="upload" type="file">
<button class="btn btn-primary" type="submit">Upload</button>
</form>
    )
  end

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
end
