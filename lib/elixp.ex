defmodule AList do
  @enforce_keys [:items]
  defstruct [:items]

  @type t() :: %__MODULE__{
    items: AAtom | AList
  }
end

defmodule AAtom do
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
      %AAtom{value: float}
    else
      %AAtom{value: atom}
    end
  end

  @delimiters %{:open => "(", :close => ")", :separator => " "}

  # def parseListActual(acc, result, elements, i, n) when i == n, do: result
  # def parseListActual(acc, result, elements, i, n) do
  #   # This should be the end
  #   if String.at(elements, i) == @delimiters[:close] do
  #     IO.puts "exit"
  #     IO.puts result
  #   end

  #   # This is the start
  #   if String.at(elements, i) == @delimiters[:open] do
  #     IO.puts "enter"
  #     parseListActual(acc, result, elements, i + 1, n)
  #   end

  #   if String.at(elements, i) != @delimiters[:separator] do
  #     newAcc = [acc | [String.at(elements, i)]]
  #     parseListActual(newAcc, result, elements, i + 1, n)
  #   end

  #   if String.at(elements, i) == @delimiters[:separator] do
  #     newResult = [[Enum.join(acc)] | result]
  #     IO.puts newResult
  #     parseListActual([], newResult, elements, i + 1, n)
  #   end
  # end

  def parseList(str) do
    if String.length(str) == 0, do: raise "Invalid string"

    list = String.trim(str)
    if String.at(list, 0) != "(", do: raise "Missing opening parens"
    if String.at(list, String.length(list) - 1) != ")", do: raise "Missing closing parens"

    atoms = list
    |> String.slice(1..String.length(list) - 2)
    |> String.split()
    |> Enum.map(fn x -> parseAtom(x) end)

    %AList{items: atoms} 
  end
end
