defmodule AppWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  # 获取 url query 中的 locale 
  # URL?locale=fr
  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  # route 中 plug App.Plugs.Locale, "en"
  def call(conn, default) do
    assign(conn, :locale, default)
  end
end
