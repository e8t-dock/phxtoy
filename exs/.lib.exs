# import IEx.Lib.Fun
File.read!("./.fun.exs")
|> Code.compile_string()

"import IEx.Lib.Fun"
|> Code.compile_string()
