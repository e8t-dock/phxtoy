defmodule AppWeb.UploadController do
  use AppWeb, :controller

  # plug AppWeb.Plugs.BasicAuth

  def index(conn, _params) do
    render(conn, "new.html")
  end

  def show(conn, _params) do
    render(conn, "show.html")
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"upload" => %Plug.Upload{} = upload}) do
    IO.inspect(upload, label: "UPLOAD")

    case handle_upload(upload) do
      :ok ->
        IO.inspect("OK")
        put_flash(conn, :info, "File #{upload.filename} uploaded correctly")
        redirect(conn, to: Routes.upload_path(conn, :index))

      {:error, reason} ->
        put_flash(conn, :error, "Error in upload file #{inspect(reason)}")
        render(conn, "new.html")
    end

    # text(conn, 'OK')
  end

  def create(conn, params) do
    IO.inspect(params, label: "POST params")

    files =
      params
      |> Enum.filter(fn
        {_, %Plug.Upload{}} -> true
        {_, _} -> false
      end)

    files
    |> Enum.each(fn {_, file} ->
      case handle_upload(file) do
        :ok ->
          IO.inspect("OK")
          # json(conn, %{status: "ok"})

          render(conn, "api_done.json", %{})

        {:error, reason} ->
          # json(conn, %{status: "failed", reason: inspect(reason)})
          render(conn, "api_error.json", reason: reason)
      end
    end)

    text(conn, 'OK')
  end

  defp handle_upload(%Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    IO.inspect([filename, content_type])
    File.cp(tmp_path, upload_path(filename))
  end

  defp upload_path(filename),
    do: [Application.get_env(:app, :uploads_directory), filename] |> Path.join()
end
