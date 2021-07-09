defmodule Elixp do
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

  def parseListInitial(["(" | xs]) do
    parseList([], xs)
  end

  # This is where the parsing ends
  def parseList(acc, [")" | xs]) do
    {Enum.reverse(acc), xs}
  end

  # Transform '(abc def) into ["quote", "abc", "def"]
  def parseList(acc, ["'" | xs]) do
    {y, ys} = parseList([], xs)
    parseList([["quote" | List.flatten(y)], acc], ys)
  end 

  # Create a new subtree
  def parseList(acc, ["(" | xs]) do
    {y, ys} = parseList([], xs)
    parseList([y | acc], ys)
  end 
  
  def parseList(acc, [x | xs]) do
    parseList([parseAtom(x) | acc], xs)
  end 
  
  def parseInput(str) do
    s = String.trim(str)

    if String.length(str) == 0,
      do: raise "Invalid string"
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

  def parse(str) do
    {result, _} = str
    |> parseInput
    |> parseListInitial
    result
  end
end
