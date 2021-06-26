defmodule AList do
  defstruct [:items]
end

defmodule Elixp do
  @typedoc """
   This is supposed to represent an Atom,
   but that's already a thing in Elixir.
   """
  @type aAtom :: charlist | integer | float

  def toChars(str) do
    String.graphemes(str)
  end

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

  @delimiters %{"open" => "(", "close" => ")"}

  def parseList(str) do
    if String.length(str) == 0, do: raise "Invalid string"
    list = String.trim(str)
    if String.at(list, 0) != "(", do: raise "Missing opening parens"

    %AList{items: []}
  end
 end
