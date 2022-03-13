defmodule EvalTest do
  use ExUnit.Case
  doctest Eval
  import ExpectFailure

  test "should return the sum of args" do
    assert Eval.eval(["+", 1, 2]) == 3
  end

  test "should return the sum of args, with nested sum expressions" do
    assert Eval.eval(["+", 1, 2, ["+", 1, 2]]) == 6
  end
end
