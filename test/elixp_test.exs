defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp

  test "returns a list of chars" do
    assert Elixp.toChars("hello") == ["h", "e", "l", "l", "o"]
  end

  test "returns a float" do
    assert Elixp.parseUnit("123.2") == 123.2
    assert Elixp.parseUnit("123") == 123
  end

  test "returns a trimmed string" do
    assert Elixp.parseUnit(" asd ") == "asd"
    assert Elixp.parseUnit(" 123 . 2 ") == "123 . 2"
  end
 
end
