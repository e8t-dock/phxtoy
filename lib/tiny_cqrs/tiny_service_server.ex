defmodule App.Tiny.Service.Server do
  use GenServer
  require Logger

  alias App.Tiny.Service.MnesiaHelper

  def start_link(opts \\ []) do
    Logger.info(opts |> inspect())
    # opts = opts |> Keyword.put_new(:name, __MODULE__)
    {name, opts} = opts |> Keyword.pop(:name, __MODULE__)

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def child_spec(opts \\ []) do
    Logger.info("yo yo, server child_spec #{inspect(opts)}")

    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, opts}
    }
  end

  @impl true
  def init(state) do
    Logger.info("yo yo, server init")
    {:ok, state}
  end

  @impl true
  def handle_call({:update_record, table, data}, from, state) do
    Logger.info([from])
    MnesiaHelper.update(table, data)
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:get_record, table, id}, from, state) do
    Logger.info([from])
    MnesiaHelper.get(table, id)
    {:reply, :ok, state}
  end
end
