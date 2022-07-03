defmodule App.Tiny.CQRS.EventHandler do
  alias :gen_event, as: GenEvent

  @behaviour GenEvent
  require Logger

  @when_backup 3

  def init(state) do
    Logger.info("Initalize event handler: #{state |> inspect()}")
    # {:ok, state}
    {:ok, {:changes_count, 0}}
  end

  def handle_event({:command, usecs, server_name, command}, {:changes_count, count}) do
    if count >= @when_backup do
      Logger.info("Time to backup count: #{count}")
      {:ok, {:changes_count, 0}}
    else
      Logger.info("NOT Time to backup count: #{count}")
      Logger.info({:command, usecs, server_name, command} |> inspect())
      {:ok, {:changes_count, count + 1}}
    end
  end

  def handle_event(event, state) do
    Logger.info("*** Got event #{event}")
    {:ok, state}
  end

  def handle_call(request, state) do
    Logger.info("*** Got request #{request}")
    {:ok, state, state}
  end

  def handle_info(info, state) do
    Logger.info("*** Got info #{info}")
    {:noreply, state}
  end
end
