defmodule RustNifTest do
  use ExUnit.Case
  doctest RustNif

  test "greets the world" do
    assert RustNif.hello() == :world
  end
end
