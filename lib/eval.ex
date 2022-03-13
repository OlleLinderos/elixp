defmodule Eval do
  @moduledoc """
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

  def init(x) do
    eval(processList(x))
  end

  def eval([x | xs]) do
    case x do
      "+" -> Enum.sum(xs)
      "-" -> Enum.reduce(xs, fn z, acc -> acc - z end)
      _ -> raise "x is not a valid operator"
    end
  end


  @doc """
  Traverse list until we get to a list where none of its elements is a list, in which
  case we evaluate it.
  """
  def processList([[_|_] = x | [_|_] = xs]) do
    [eval(processList(x)) | processList(xs)]
  end

  def processList([x | xs]) when is_list(x) do
    [eval(processList(x)) | xs]
  end
  
  def processList([x | [_|_] = xs]) do
    [x | processList(xs)]
  end

  # Deepest list
  def processList([x]) do [x] end
end
