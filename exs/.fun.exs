defmodule IEx.Lib do
  defmacro __using__(_opt) do
    quote do
      def exit(), do: :erlang.halt()
    end
  end

  defmodule Fun do
    def exit(), do: :erlang.halt()
    def ping(), do: :pong
  end

  # :erlang.halt()
end
