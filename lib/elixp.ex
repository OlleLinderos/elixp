defmodule Elixp do
  @spec main(binary) :: any
  def main(input) do
    input
    |> Lexer.parse
    |> Eval.eval
  end
end
