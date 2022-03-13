defmodule EvalTest do
  use ExUnit.Case
  doctest Eval
  import ExpectFailure

  test "should raise an exception if operator doesn't exist", do:
    expect_failure(Eval.init(["~", 1, 2]))


  # Addition
  test "should return the sum of args", do:
    assert Eval.init(["+", 1, 2]) == 3

  test "should return the sum of args, with nested sum expressions", do:
    assert Eval.init(["+", 1, 2, ["+", 3, 4]]) == 10

  test "should return the sum of args, when arg is trailing list", do:
    assert Eval.init(["+", 1, 2, ["+", 3, 4], 5]) == 15 

  test "should return the sum of args, with multiple lists on same depth", do:
    assert Eval.init(["+", ["+", 1], ["+", 2], ["+", 3]]) == 6 


  # Subtraction
  test "should subract from right to left", do:
    assert Eval.init(["-", 1, 2]) == -1

  test "should subract with nested expressions", do:
    assert Eval.init(["-", 10, ["+", 2, 3]]) == 5

  test "double negative?", do:
    assert Eval.init(["-", 10, ["-", 2, 3]]) == 11


  # Multiplication
  test "should multiply args", do:
    assert Eval.init(["*", 1, 2]) == 2 

  test "should multiply nested args" do
    assert Eval.init(["*", 1, 2, ["+", 3, 4]]) == 14 
    assert Eval.init(["*", 1, 2, ["*", 3, 4]]) == 24 
  end


  # Division
  test "should divide args" do
    assert Eval.init(["/", 4, 2]) == 2
    assert Eval.init(["/", 4, 2, 2]) == 1
  end

  test "should divide with nested args", do:
    assert Eval.init(["/", 4, ["/", 8, 2]]) == 1


  # Primitive operators
  test "should return a linked list args as elements", do:
    assert Eval.init(["quote", 1, 2]) == [1, 2]

  test "should return head element in list", do:
    assert Eval.init(["car", ["quote", 1, 2]]) == 1
    assert Eval.init(["car", ["quote", ["quote", 1, 2]]]) == [1, 2]

  test "should return tail element in list", do:
    assert Eval.init(["cdr", ["quote", 1, 2]]) == [2]
    assert Eval.init(["cdr", ["quote", 1, 2, 3, 4]]) == [2, 3, 4]
    assert Eval.init(["cdr", ["quote", 1, 2, ["quote", 3, 4], 5]]) == [2, [3, 4], 5]
end
