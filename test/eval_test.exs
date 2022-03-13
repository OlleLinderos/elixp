defmodule EvalTest do
  use ExUnit.Case
  doctest Eval
  import ExpectFailure

  test "should raise an exception if operator doesn't exist" do
    expect_failure(Eval.init(["~", 1, 2]))
  end

  test "should return the sum of args" do
    assert Eval.init(["+", 1, 2]) == 3
  end

  test "should return the sum of args, with nested sum expressions" do
    assert Eval.init(["+", 1, 2, ["+", 3, 4]]) == 10
  end

  test "should return the sum of args, when arg is trailing list" do
    assert Eval.init(["+", 1, 2, ["+", 3, 4], 5]) == 15 
  end

  test "should return the sum of args, with multiple lists on same depth" do
    assert Eval.init(["+", ["+", 1], ["+", 2], ["+", 3]]) == 6 
  end
end
