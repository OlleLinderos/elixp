defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp
  import ExpectFailure
  import AList

  test "returns a float" do
    assert Elixp.parseAtom("123.2") == 123.2
    assert Elixp.parseAtom("123") == 123
  end

  test "returns a trimmed string" do
    assert Elixp.parseAtom(" asd ") == "asd"
    assert Elixp.parseAtom(" 123 . 2 ") == "123 . 2"
  end

  test "will raise runtimeError" do
    expect_failure(Elixp.parseList(""))
  end

  test "should throw if opening parens is missing" do
    expect_failure(Elixp.parseList("asd"))
  end

  test "returns an empty AList if empty expression" do
    assert Elixp.parseList("()") == %AList{items: []}
  end
end
