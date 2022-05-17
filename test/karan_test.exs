defmodule KaranTest do
  use ExUnit.Case
  doctest Karan

  test "greets the world" do
    assert Karan.hello() == :world
  end
end
