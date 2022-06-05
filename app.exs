# Path.join([Application.app_dir(:app), "priv/static/upload"])
# |> IO.inspect()

# with {:ok, a} <- {:ok, 1},
#      {:ok, b} <- {:bad, 2} do
#   IO.inspect({a, b})
# else
#   {:error, _} ->
#     IO.inspect("error")

#   {:bad, _} ->
#     IO.inspect("bad")
# end

{_, tag} = Phoenix.HTML.Tag.csrf_input_tag("/upload")

tag =
  tag
  |> List.flatten()
  |> Enum.map(fn
    token when is_integer(token) -> [token] |> List.to_string()
    token -> token
  end)
  |> Enum.join()

IO.inspect(tag)

# {:function_clause, [{:cowboy_http, :commands, [{:state, #PID<0.432.0>, AppWeb.Endpoint.HTTP, #Port<0.72>, :ranch_tcp, :undefined, %{env: %{dispatch: [{:_, [], [{:_, [], Phoenix.Endpoint.Cowboy2Handler, {AppWeb.Endpoint, []}}]}]}, stream_handlers: [:cowboy_telemetry_h, :cowboy_stream_h]}, "", %{}, {{192, 168, 101, 10}, 52598}, {{192, 168, 101, 11}, 4000}, :undefined, #Reference<0.1118117947.762576900.180992>, true, 3, {:ps_request_line, 0}, :infinity, 2, :done, 1000, [{:stream, 2, {:cowboy_telemetry_h, {:state, {:cowboy_stream_h, {:state, :undefined, AppWeb.Endpoint.HTTP, #PID<0.1106.0>, :undefined, #PID<0.1106.0>, :undefined, :undefined, 1000000, :nofin, "", 5510357, ...}}, #Function<0.118987493/1 in :cowboy_telemetry_h."-fun.metrics_callback/1-">, :undefined, %{body_length: 5510357, cert: :undefined, has_body: true, headers: %{"accept" => "*/*", "accept-encoding" => "gzip, deflate", "accept-language" => "en-US,en;q=0.5", "cache-control" => "no-cache", "connection" => "keep-alive", "content-length" => "5510357", "content-type" => "multipart/form-data; boundary=---------------------------24393172914522891944124192113", ...}, host: "192.168.101.11", method: "POST", path: "/api/upload", peer: {{192, 168, ...}, 52598}, pid: #PID<0.1101.0>, port: 4000, qs: "", ...}, "200 OK", %{"access-control-allow-credentials" => "true", "access-control-allow-origin" => "*", "access-control-expose-headers" => "", "cache-control" => "max-age=0, private, must-revalidate", "content-length" => "2", "content-type" => "text/plain; charset=utf-8", "date" => "Sun, 05 Jun 2022 18:12:10 GMT", "server" => "Cowboy", "x-request-id" => "FvXL_htMCWitkhAAAA2k"}, AppWeb.Endpoint.HTTP, -576459977185222000, :undefined, -576459977185186000, -576459976749852000, -576459976733686000, -576459976733686000, %{#PID<0.1106.0> => %{...}}, [], ...}}, "POST", :"HTTP/1.1", :undefined, :undefined, 0, []}], [{:child, #PID<0.1106.0>, 2, 5000, :undefined}]}, 2, [{:response, "200 OK", %{"access-control-allow-credentials" => "true", "access-control-allow-origin" => "*", "access-control-expose-headers" => "", "cache-control" => "max-age=0, private, must-revalidate", "content-length" => "2", "content-type" => "text/plain; charset=utf-8", "date" => "Sun, 05 Jun 2022 18:12:10 GMT", "server" => "Cowboy", "x-request-id" => "FvXL_htMCWitkhAAAA2k"}, "OK"}]], [file: '/Users/quantum/Desktop/app/elixir/phx/deps/cowboy/src/cowboy_http.erl', line: 957]}, {:cowboy_http, :loop, 1, [file: '/Users/quantum/Desktop/app/elixir/phx/deps/cowboy/src/cowboy_http.erl', line: 257]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 226]}]}
