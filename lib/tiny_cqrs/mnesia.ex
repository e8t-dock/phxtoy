defmodule App.Tiny.Service.MnesiaHelper do
  use GenServer
  require Logger
  alias :mnesia, as: Mnesia

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def init(state) do
    setup_mnesia()
    {:ok, state}
  end

  def setup_mnesia() do
    Logger.info("Setting up mnesia...")
    :ok = ensure_schema_exists()
    :ok = Mnesia.start()
    :ok = ensure_table_exists()
    Logger.info("mnesia is running now...")
  end

  defp ensure_schema_exists() do
    case Mnesia.create_schema([node()]) do
      {:error, {_node, {:already_exists, __node}}} -> :ok
      :ok -> :ok
      reason -> IO.inspect(reason)
    end
  end

  defp ensure_table_exists() do
    Mnesia.create_table(
      News,
      attributes: [
        :id,
        :content,
        :upvote,
        :downvote
      ]
    )
    |> case do
      {:atomic, :ok} -> :ok
      {:aborted, {:already_exists, News}} -> :ok
    end

    :ok = Mnesia.wait_for_tables([News], 5000)
  end

  def update(table, data) when is_list(data) do
    fn ->
      for elem <- data do
        elem
        |> Tuple.insert_at(0, table)
        |> Mnesia.write()
      end
    end
    |> Mnesia.transaction()
  end

  def update(table, data) do
    fn ->
      data
      |> Tuple.insert_at(0, table)
      |> Mnesia.write()
    end
    |> Mnesia.transaction()
  end

  def get(table, id) do
    fn ->
      {table, id}
      |> Mnesia.read()
    end
    |> Mnesia.transaction()
  end
end
