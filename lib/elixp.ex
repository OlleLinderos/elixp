defmodule Elixp do
  def main(input) do
    input
    |> Lexer.parse()
    |> Eval.init()
    |> inspect
    |> IO.puts()
  end
end
