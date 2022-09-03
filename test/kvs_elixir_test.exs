defmodule KvsElixirTest do
  use ExUnit.Case
  doctest KvsElixir

  test "greets the world" do
    assert KvsElixir.hello() == :world
  end
end
