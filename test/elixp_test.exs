defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp
  import ExpectFailure
  import AList

  test "returns a float" do
    assert Elixp.parseAtom("123.2").value == 123.2
    assert Elixp.parseAtom("123").value == 123
  end

  test "returns a string" do
    assert Elixp.parseAtom(" asd ").value == "asd"
    assert Elixp.parseAtom("a-sd").value == "a-sd"
    assert Elixp.parseAtom("a_sd").value == "a_sd"
  end

  test "will raise runtimeError" do
    expect_failure(Elixp.parseList(""))
  end

  test "should throw if opening parens is missing" do
    expect_failure(Elixp.parseList("asd"))
  end

  test "should throw if closing parens is missing" do
    expect_failure(Elixp.parseList("(asd"))
  end

  test "returns an empty AList if empty expression" do
    assert Elixp.parseList("()") == %AList{items: []}
  end

  test "returns a AList with number AAtom" do
    assert Elixp.parseList("(123)") == %AList{
      items: [%AAtom{value: 123.0}]
    }
  end

  test "returns a AList with string AAtom" do
    assert Elixp.parseList("(a)") == %AList{
      items: [%AAtom{value: "a"}]
    }
  end

  test "returns a AList with multiple AAtoms" do
    assert Elixp.parseList("(a-bc 123 0 bb)") == %AList{
      items: [%AAtom{value: "a-bc"},
              %AAtom{value: 123.0},
              %AAtom{value: 0.0},
              %AAtom{value: "bb"}]
    }
  end

end
