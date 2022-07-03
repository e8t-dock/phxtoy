defmodule App.Tiny.CQRS.EventDispatcher do
  alias :gen_event, as: GenEvent
  alias App.Tiny.CQRS.EventHandler

  require Logger

  def start_link(opts \\ []) do
    Logger.info("Staring event dispatcher opts: #{opts |> inspect()}")

    # :ok = GenEvent.add_handler(__MODULE__, EventHandler, [0])
    # :ok = GenEvent.add_handler(__MODULE__, EventHandler, 0)
    {:ok, pid} = GenEvent.start_link({:local, __MODULE__})
    :ok = GenEvent.add_handler(__MODULE__, EventHandler, {:changes_count, 0})
    {:ok, pid}
  end

  def init(opts \\ []) do
    Logger.info("Staring event dispatcher init opts: #{opts |> inspect()}")
    {:ok, [opts]}
  end

  def child_spec(opts \\ []) do
    Logger.info("Staring event dispatcher child_spec opts: #{opts |> inspect()}")
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opts]}}
  end

  def notify(usecs, server_name, command) do
    GenEvent.notify(__MODULE__, {:command, usecs, server_name, command})
  end

  def call(request) do
    GenEvent.call(__MODULE__, EventHandler, request)
  end
end
