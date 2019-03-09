defmodule TokexTest do
  use ExUnit.Case
  doctest Tokex

  test "greets the world" do
    assert Tokex.hello() == :world
  end
end
