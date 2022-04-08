defmodule Elixp do
  def main(input) do
    input
    |> Lexer.parse()
    |> Eval.init()
  end
end
