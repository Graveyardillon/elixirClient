defmodule HttpclientTest do
  use ExUnit.Case
  doctest Httpclient

  test "greets the world" do
    assert Httpclient.hello() == :world
  end
end
