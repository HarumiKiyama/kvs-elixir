defmodule KvstoreTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, store} = Kvstore.start_link()
    {:ok, store: store}
  end
  test "crud value in store", %{store: store} do
    {:ok, file} = :file.open("/tmp/db", [:write, :append, :read])
    Kvstore.set("k1", "huhuhu", store, file)
    Kvstore.set("k2", "xixixi", store, file)
    command = struct(Command, Kvstore.get("k1", store, file))
    assert command.val == "huhuhu"
  end

  test "remove none existence key in store", %{store: store} do

  end

  test "compact log file", %{store: store} do

  end

end
