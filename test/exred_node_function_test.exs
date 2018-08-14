defmodule Exred.Node.FunctionTest do
  use ExUnit.Case
  doctest Exred.Node.Function

  test "greets the world" do
    assert Exred.Node.Function.hello() == :world
  end
end
