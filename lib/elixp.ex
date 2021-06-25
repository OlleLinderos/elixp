defmodule Elixp do
  @typedoc """
   This is supposed to represent an Atom,
   but that's already a thing in Elixir.
   """
  @type unit :: charlist | integer | float

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
  def parseUnit(str) do
    unit = String.trim(str)
    if is_numeric(unit) do
      {float, _} = Float.parse(unit)
      float
    else
      unit
    end
  end


 end
