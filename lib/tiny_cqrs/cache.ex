defmodule App.Tiny.Service.Cache do
  use Agent

  def start_link(opts \\ []) do
    {state, opts} = Keyword.pop(opts, :state, %{})
    opts = opts |> Keyword.put_new(:name, __MODULE__)
    Agent.start_link(fn -> state end, opts)
  end

  # def init(state \\ %{}) do
  #   {:ok, state}
  #   |> IO.inspect()
  # end

  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def update(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
  end
end
