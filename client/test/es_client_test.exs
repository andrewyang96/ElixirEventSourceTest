defmodule EsClientTest do
  use ExUnit.Case
  doctest EsClient

  test "greets the world" do
    assert EsClient.hello() == :world
  end
end
