defmodule ElixpTest do
  use ExUnit.Case
  doctest Elixp

  test "greets the world" do
    assert Elixp.hello() == :nope
  end
end
