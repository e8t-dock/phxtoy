defmodule App.Tiny.CQRS.Macro do
  # @server_name App.Tiny.Service.Server
  alias App.Tiny.Service.Cache
  alias App.Tiny.CQRS.EventDispatcher

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc "Cached a query"
  # defmacro cached(cacheName, key, do: block) do
  #   quote bind_quoted: [cacheName: cacheName, key: key], unquote: true do
  #     cached_value = CacheServer.get_cached(cacheName, key)
  defmacro cached(name, query, do: block) do
    quote bind_quoted: [name: name, query: query], unquote: true do
      cached_value = Cache.get({name, query})

      if cached_value != nil do
        cached_value
      else
        value = unquote(block)

        case value do
          nil ->
            value

          {:error, _} ->
            value

          _ ->
            Cache.update({name, query}, value)
            value
        end
      end
    end
  end

  @doc "Execute a command"
  defmacro command(name, command) do
    quote bind_quoted: [name: name, command: command], unquote: true do
      usecs = DateTime.utc_now() |> DateTime.to_unix()
      # result = GenServer.call(@server_name, {:update_record, id, field_and_value})
      # {:update_record, 1, {"Erlang News", 10, 10}}
      result = GenServer.call(name, command)
      # EventManager.notify_command(usecs, name, command)
      EventDispatcher.notify(usecs, name, command)
      result
    end
  end

  @doc "Execute a query"
  # (News, 1)
  defmacro query(name, query, caching \\ true) do
    quote bind_quoted: [name: name, query: query], unquote: true do
      if unquote(caching) do
        cached(name, query) do
          GenServer.call(name, query)
        end
      else
        GenServer.call(name, query)
      end
    end
  end
end
