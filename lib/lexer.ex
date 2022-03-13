defmodule Lexer do
  @moduledoc """
  Module for turning strings containing Lisp expressions into linked lists with Elixir basic types.
  """

  @spec parseAtom(binary) :: binary | number
  def parseAtom(str) do
    if String.length(str) == 0, do: raise "Invalid string"
    s = String.trim(str)

    case Integer.parse(s) do
      {int, ""} -> int
      _        ->
        case Float.parse(s) do
          {float, ""} -> float
          _ -> s
        end
    end
  end


  @doc """
  Takes a Lisp expression and turns it into a linked list.

  (car '(a b c)) => ["car", ["quote", "a", "b", "c"]]
  """
  # Parsing begins here
  def parseList(["(" | xs]), do: parseList([], xs)

  # Parsing ends here
  def parseList(acc, [")" | xs]), do: {Enum.reverse(acc), xs}

  # Create a new subtree where '(abc def) transforms into ["quote", "abc", "def"]
  def parseList(acc, ["'" | xs]) do
    {y, ys} = parseList([], List.delete_at(xs, 0))
    parseList([["quote" | y] | acc], ys)
  end

  # Create a new subtree
  def parseList(acc, ["(" | xs]) do
    {y, ys} = parseList([], xs)
    parseList([y | acc], ys)
  end

  # Parse atoms
  def parseList(acc, [x | xs]), do: parseList([parseAtom(x) | acc], xs)


  @doc """
  Prepare string for parsing, by separating parens from adjacent symbols.
  """
  def parseInput(str) do
    s = String.trim(str)

    if String.length(s) == 0,
      do: raise "Invalid input"
    if String.at(s, 0) != "(",
      do: raise "Missing opening parens"
    if String.at(s, String.length(s) - 1) != ")",
      do: raise "Missing closing parens"
    if length(Regex.scan(~r/\(/, s)) != length(Regex.scan(~r/\)/, s)),
      do: raise "Unbalanced parens"

    s
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.replace("'", " ' ")
    |> String.split()
  end


  @spec parse(binary) :: list
  def parse(str) do
    {result, _} = str
    |> parseInput
    |> parseList
    result
  end
end
