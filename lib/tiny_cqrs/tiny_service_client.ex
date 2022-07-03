# http://jfcloutier.github.io/jekyll/update/2015/11/04/cqrs_elixir_phoenix.html

defmodule App.Tiny.Service.Client do
  use GenServer
  use App.Tiny.CQRS.Macro

  @server_name App.Tiny.Service.Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  def update_record(table, fields) do
    # Client.update_record(News, {1, "Erlang News", 11, 11})
    # GenServer.call(@server_name, {:update_record, tabel, fields})
    command(@server_name, {:update_record, table, fields})
  end

  def get_record(table, id) do
    # GenServer.call(@server_name, {:get_record, table, id})
    query(@server_name, {:get_record, table, id})
  end
end
