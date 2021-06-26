defmodule AList do
  defstruct [:items]
end

defmodule Elixp do
  @typedoc """
   This is supposed to represent an Atom,
   but that's already a thing in Elixir.
   """
  @type aAtom :: charlist | integer | float

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
    atom = String.trim(str)
    if String.length(atom) == 0, do: raise "Invalid string"
    if is_numeric(atom) do
      {float, _} = Float.parse(atom)  
      float
    else
      atom
    end
  end

  @delimiters %{:open => "(", :close => ")"}


  def parseListActual(elements, n) when n <= 1 do
    IO.puts "we're done here"
  end

  def parseListActual(elements, n) do
    result = %AList{items: []}

    if String.at(elements, n) == @delimiters[:close] do
      result
    end
    if String.at(elements, n) == @delimiters[:open] do
      r = parseListActual(elements, n + 1)
      Map.put(result, :items [r])
    end
    
    parseListActual(elements, n - 1)
  end

  def parseList(str) do
    if String.length(str) == 0, do: raise "Invalid string"
    list = String.trim(str)
    if String.at(list, 0) != "(", do: raise "Missing opening parens"

    elements = String.graphemes(list)
    result = parseListActual(list, length(elements))

    result
  end
 end
