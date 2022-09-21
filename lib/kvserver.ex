defmodule KvServer do
  use GenServer
  require Logger

  def start_link() do
    file_path = Application.get_env(:kvserver, :file_path, "/tmp/kv.db")
    port = Application.get_env(:kvserver, :port, 6666)
    GenServer.start_link(__MODULE__, [file_path, port], [])
  end

  @impl true
  def init([file_path, port]) do
    with {:ok, listen_socket} <-
           :gen_tcp.listen(port, [:binary, {:packet, 0}, {:active, true}, {:ip, "127.0.0.1"}]),
         {:ok, socket} <- :gen_tcp.accept(listen_socket),
         do: {:ok, %{file_path: file_path, port: port, socket: socket, db: %{}}}
  end

  @impl true
  def handle_call(%Command{method: :get, key: key, val: _val}, _from, state) do
    {:reply, Kvstore.get(key, state[:db], state[:file_path]), state}
  end

  @impl true
  def handle_call(%Command{method: :set, key: key, val: val}, _from, state) do
    db = Kvstore.set(key, val, state[:db], state[:file_path])
    {:reply, :ok, Kernel.put_in(state[:db], db)}
  end

  @impl true
  def handle_call(%Command{method: :rm, key: key, val: _val}, _from, state) do
    db = Kvstore.remove(key, state["db"], state["file_path"])
    {:reply, :ok, Kernel.put_in(state[:db], db)}
  end

  @impl true
  def handle_cast(:compact, state) do
    {:noreply, state}
  end
end
