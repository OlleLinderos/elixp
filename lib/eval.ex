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
  def processList([[_|_] = x | [_|_] = xs]),
    do: [eval(processList(x)) | processList(xs)]

  # We've reached a subtree, x is a list and xs is an empty list.
  # Its pattern will match the definition below next, and begin parsing anew.
  def processList([x | xs]) when is_list(x) and is_list(xs),
    do: [eval(processList(x)) | xs]

  # Processing begins here, will call itself until x is a list
  def processList([x | [_|_] = xs]),
    do: [x | processList(xs)]

  # Processing ends here, x does not contain any lists
  def processList([x]), do: [x]


  @doc """
  Primitive operators

  (quote x) returns x. For readability we will abbreviate (quote x) as 'x.

  (atom x) returns the atom t if the value of x is an atom or the empty
  list. Otherwise it returns (). In Lisp we conventionally use the atom t to
  represent truth and the empty list to represent falsity.

  (eq x y) returns t if the values of x and y are the same atom or both the
  empty list, and () otherwise.

  (car x) expects the value of x to be a list, and returns its first element.

  (cdr x) expects the value of x to be a list, and returns everything after
  the first element.

  (cons x y) expects the value of y to be a list, and returns a list containing
  the value of x followed by the elements of the value of y.

  (cond (p_1 e_1) ... (p_n e_n)) is evaluated as follows. The p expressions are
  evaluated in order until one returns t. When one is found the value of
  the corresponding e expression is returned as the value of the whole cond
  expression.

  Source: Roots of Lisp, Paul Graham http://languagelog.ldc.upenn.edu/myl/llog/jmc.pdf
  """
  def eval(["quote" | x]), do: x
  def eval(["car" | [[x | _]]]), do: x
  def eval(["cdr" | [[_ | xs]]]), do: xs

  # Arithmetic operators
  def eval(["+" | xs]), do: Enum.sum(xs)
  def eval(["-" | xs]), do: Enum.reduce(xs, fn y, acc -> acc - y end)
  def eval(["*" | xs]), do: Enum.reduce(xs, fn y, acc -> acc * y end)
  def eval(["/" | xs]), do: Enum.reduce(xs, fn y, acc -> acc / y end)
  
  def eval([x | xs]), do: raise x <> " is not a valid operator given " <> xs <> " args"
end
