defmodule App.Mvp.Ps do
  @content Path.join([Application.get_env(:app, :out_dir), "ps.txt"]) |> File.read!()

  @eex_quoted Path.join([Application.get_env(:app, :out_dir), "sample.eex"]) |> EEx.compile_file()

  @oops &__MODULE__.eex/0

  def cat(), do: @content

  def eex() do
    {result, _} = Code.eval_quoted(@eex_quoted, a: 10, b: 20)
    result
  end

  # App.Mvp.Ps.eex().()
  def oops(), do: @oops
end
