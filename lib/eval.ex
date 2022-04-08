defmodule Eval do
  @moduledoc """
  Module for evaluation order, primitive and arithmetic operators.
  """

  def init(x), do: eval(processList(x))

  @doc """
  Traverse list until we get to a list where none of its elements is a list, in which
  case we evaluate it. Probably incredibly inefficiently. Writing this introduced me
  to the Elixir debugger.
  """
  # This will match if both the head and the tail are nonempty lists, which
  # gives us the ability to carry the remainder of the current tree once we've
  # encountered a subtree.
  def processList([[_ | _] = x | [_ | _] = xs]),
    do: [eval(processList(x)) | processList(xs)]

  # We've reached a list, x is a list and xs is an empty list.
  # Its pattern will match the definition below next, and begin parsing anew.
  def processList([x | xs]) when is_list(x) and is_list(xs),
    do: [eval(processList(x)) | xs]

  # Processing begins here, will call itself until x is a list
  def processList([x | [_ | _] = xs]),
    do: [x | processList(xs)]

  # Processing ends here, x does not contain any lists
  def processList([x]), do: [x]

  @doc """
  Evaluate primitive and arithmetic operators.

  Definitions below copied from Roots of Lisp, Paul Graham http://languagelog.ldc.upenn.edu/myl/llog/jmc.pdf
  """
  # (quote x) returns x. For readability we will abbreviate (quote x) as 'x.
  def eval(["quote" | x]), do: x

  # (atom x) returns the atom t if the value of x is an atom or the empty
  # list. Otherwise it returns (). In Lisp we conventionally use the atom t to
  # represent truth and the empty list to represent falsity.
  def eval(["atom"]), do: raise("(atom x) requires 1 parameter")
  def eval(["atom" | [[_ | _]]]), do: []
  def eval(["atom" | _]), do: true

  # (eq x y) returns t if the values of x and y are the same atom or both the
  # empty list, and () otherwise.
  def eval(["eq" | [x | [_ | _] = xs]]),
    do: if(Enum.all?(xs, &(&1 === x)), do: true, else: [])

  # (car x) expects the value of x to be a list, and returns its first element.
  def eval(["car" | [[x | _]]]), do: x

  # (cdr x) expects the value of x to be a list, and returns everything after
  # the first element.
  def eval(["cdr" | [[_ | xs]]]), do: xs

  # (cons x y) expects the value of y to be a list, and returns a list containing
  # the value of x followed by the elements of the value of y.
  def eval(["cons" | [x | [xs]]]) when is_list(xs) do
    [x | xs]
  end

  # (cond (p_1 e_1) ... (p_n e_n)) is evaluated as follows. The p expressions are
  # evaluated in order until one returns t. When one is found the value of
  # the corresponding e expression is returned as the value of the whole cond
  # expression.
  def eval(["cond" | x]) do
    Enum.find_value(x, fn [y | [ys]] -> if y == true, do: ys end)
  end

  # Arithmetic operators
  def eval(["+" | xs]), do: Enum.sum(xs)
  def eval(["-" | xs]), do: Enum.reduce(xs, &(&2 - &1))
  def eval(["*" | xs]), do: Enum.reduce(xs, &(&2 * &1))
  def eval(["/" | xs]), do: Enum.reduce(xs, &(&2 / &1))

  def eval(x), do: x
end
