defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp
  import ExpectFailure

  test "should pass the second argument into the lambda function" do
    assert Elixp.main("((lambda (x) (cons x '(2))) 1)") == [1, 2]
  end
end

