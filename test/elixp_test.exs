defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp
  import ExpectFailure

  test "should return an int" do
    assert Elixp.parseAtom("123") == 123
  end

  test "should return a float" do
    assert Elixp.parseAtom("123.2") == 123.2
  end

  test "should return a string" do
    assert Elixp.parseAtom(" asd ") == "asd"
    assert Elixp.parseAtom("a-sd") == "a-sd"
    assert Elixp.parseAtom("a_sd") == "a_sd"
  end
  

  test "should return a list containing an int" do
    assert Elixp.parse("(123)") == [123]
  end

  test "should return a list containing a float" do
    assert Elixp.parse("(a)") == ["a"]
  end

  test "should return a list containing a string" do
    assert Elixp.parse("(a)") == ["a"]
  end

  test "should return a list containing multiple items" do
    assert Elixp.parse("(a-bc 123.0 0 bb)") == ["a-bc", 123.0, 0, "bb"]
  end

  test "should return an empty nested list" do
    assert Elixp.parse("(ok ())") == ["ok", []]
  end

  test "should return an empty list" do
    assert Elixp.parse("()") == []
  end

  test "returns a list as 'quote'" do
    assert Elixp.parse("(abc '(test 123))") == ["abc", ["quote", "test", 123]]
  end

  
  test "will raise runtimeError if empty input" do
    expect_failure(Elixp.parseInput(""))
  end

  test "should throw if opening parens is missing" do
    expect_failure(Elixp.parseInput("asd"))
  end

  test "should throw if closing parens is missing" do
    expect_failure(Elixp.parseInput("(asd"))
  end
end
