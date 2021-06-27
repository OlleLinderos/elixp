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
    assert Elixp.parseList("()") == %EList{items: []}
  end

  test "returns a AList with number AAtom" do
    assert Elixp.parseList("(123)") == %EList{
      items: [%EAtom{value: 123.0}]
    }
  end

  test "returns a AList with string AAtom" do
    assert Elixp.parseList("(a)") == %EList{
      items: [%EAtom{value: "a"}]
    }
  end

  test "returns a AList with multiple AAtoms" do
    assert Elixp.parseList("(a-bc 123 0 bb)") == %EList{
      items: [%EAtom{value: "a-bc"},
              %EAtom{value: 123.0},
              %EAtom{value: 0.0},
              %EAtom{value: "bb"}]
    }
  end

  test "returns an empty nested list" do
    assert Elixp.parseList("(ok ())") == %EList{
       items: [%EAtom{value: "ok"},
               %EList{items: []}]
    }
  end

end
