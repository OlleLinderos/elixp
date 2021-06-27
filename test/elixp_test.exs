defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp
  import ExpectFailure

  test "returns a float" do
    assert Elixp.parseAtom("123.2").value == 123.2
    assert Elixp.parseAtom("123").value == 123
  end

  test "returns a string" do
    assert Elixp.parseAtom(" asd ").value == "asd"
    assert Elixp.parseAtom("a-sd").value == "a-sd"
    assert Elixp.parseAtom("a_sd").value == "a_sd"
  end

  test "returns a list with a number" do
    assert Elixp.parseList("(123)") == [123.0]
  end

  test "returns a AList with string AAtom" do
    assert Elixp.parseList("(a)") == ["a"] end

  test "returns a AList with multiple AAtoms" do
    assert Elixp.parseList("(a-bc 123 0 bb)") == ["a-bc", 123.0, 0.0, "bb"] end

  test "returns an empty nested list" do
    assert Elixp.parseList("(ok ())") == ["ok", []]
  end

  test "will raise runtimeError" do
    expect_failure(Elixp.parseInput(""))
  end

  test "should throw if opening parens is missing" do
    expect_failure(Elixp.parseInput("asd"))
  end

  test "should throw if closing parens is missing" do
    expect_failure(Elixp.parseInput("(asd"))
  end

  test "returns an empty list if empty expression" do
    assert Elixp.parseInput("()") == []
  end
end
