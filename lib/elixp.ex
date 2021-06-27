defmodule EList do
  @enforce_keys [:items]
  defstruct [:items]

  @type t() :: %__MODULE__{
    items: AAtom | AList
  }
end

defmodule EAtom do
  @enforce_keys [:value]
  defstruct [:value]

  @type t() :: %__MODULE__{
    value: String.t() | float()
  }
end

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
    atom = String.trim(str)
    if is_numeric(atom) do
      {float, _} = Float.parse(atom)  
      %EAtom{value: float}
    else
      %EAtom{value: atom}
    end
  end

  @delimiters %{:open => "(", :close => ")", :quote => "'"}

  def parseList(acc, [")" | xs]) do
    [Enum.reverse(acc), xs]
  end

  def parseList(acc, [")" | xs]) do
    {y, ys} = parseList([], xs)
    parseList([y | acc], ys)
  end 

  def parseList(acc, [x | xs]) do
    parseList([x | acc], xs)
  end 

  def subParse(["(" | xs]) do
    parseList([], xs)
  end
  
  def subParse([x | xs]) do
    [x, xs]
  end
  
  def prepareList(str) do
    if String.length(str) == 0, do: raise "Invalid string"

    # list = String.trim(str)
    # if String.at(list, 0) != "(", do: raise "Missing opening parens"
    # if String.at(list, String.length(list) - 1) != ")", do: raise "Missing closing parens"

    {x, xs} = str
    |> String.trim(str)
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.replace("'", " ' ")
    |> String.split()
    |> subParse()
    |> case do
         {x, xs} -> {x, xs}
       end

    parseList(x, xs)
  end
end
