defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer
  import ExpectFailure

  # Atom parsing
  test "should return an int", do:
    assert Lexer.parseAtom("123") == 123

  test "should return a float", do:
    assert Lexer.parseAtom("123.2") == 123.2

  test "should return a string" do
    assert Lexer.parseAtom(" asd ") == "asd"
    assert Lexer.parseAtom("a-sd") == "a-sd"
    assert Lexer.parseAtom("a_sd") == "a_sd"
  end
  

  # List parsing
  test "should return a list containing an int", do:
    assert Lexer.parse("(123)") == [123]

  test "should return a list containing a float", do:
    assert Lexer.parse("(a)") == ["a"]

  test "should return a list containing a string", do:
    assert Lexer.parse("(a)") == ["a"]

  test "should return a list containing multiple items", do:
    assert Lexer.parse("(a-bc 123.0 0 bb)") == ["a-bc", 123.0, 0, "bb"]

  test "should return an empty nested list", do:
    assert Lexer.parse("(ok ())") == ["ok", []]

  test "should return an empty list", do:
    assert Lexer.parse("()") == []

  test "should return a containing a 'quote' list", do:
    assert Lexer.parse("(abc '(test 123))") == ["abc", ["quote", "test", 123]]

  test "should return a containing a 'quote' list with nested lists", do:
    assert Lexer.parse("(abc '(test 123 (5 6)))") == ["abc", ["quote", "test", 123, [5, 6]]]


  # Exceptions
  test "should raise an exception if input is empty", do:
    expect_failure(Lexer.parseInput(""))

  test "should raise an exception if opening parens is missing", do:
    expect_failure(Lexer.parseInput("asd"))

  test "should raise an exception if closing parens is missing", do:
    expect_failure(Lexer.parseInput("(asd"))
end
