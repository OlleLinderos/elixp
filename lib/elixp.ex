defmodule Elixp do
  def is_numeric(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _          -> false
    end
  end

  @doc """
  Lets go with floats only for now, will likely come back to this
  """
  def parseAtom(str) do
    if String.length(str) == 0, do: raise "Invalid string"
    s = String.trim(str)
    if is_numeric(s) do
      {float, _} = Float.parse(s)  
      float
    else
      s
    end
  end


  def parseListInitial(["(" | xs]) do
    parseList([], xs)
  end

  def parseListInitial(["'" | xs]) do
    {y, ys} = parseListInitial(xs)
    [["quote", y] | ys]
  end
  
  def parseListInitial([x | xs]) do
    [x, xs]
  end


  def parseList(acc, [")" | xs]) do
    IO.puts acc
    IO.puts xs
    [Enum.reverse(acc), xs]
  end

  def parseList(acc, ["(" | xs]) do
    {y, ys} = parseList([], xs)
    parseList([y | acc], ys)
  end 

  def parseList(acc, [x | xs]) do
    parseList([x | acc], xs)
  end 

  
  def parseInput(str) do
    s = String.trim(str)
    if String.length(str) == 0, do: raise "Invalid string"
    if String.at(s, 0) != "(", do: raise "Missing opening parens"
    if String.at(s, String.length(s) - 1) != ")", do: raise "Missing closing parens"

    s
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.replace("'", " ' ")
    |> String.split()
  end

  def parse(str) do
    str
    |> parseInput
    |> parseListInitial
    # |> List.first()
  end
end
