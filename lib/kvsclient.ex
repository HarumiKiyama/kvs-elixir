defmodule Kvsclient do
  def get(key, addr) do
    :ok = send_to_server(struct(Command, [method: :get, key: key]), addr)
  end

  def set(key, val, addr) do
    :ok = send_to_server(struct(Command, [method: :set, key: key, val: val]), addr)
  end

  def rm(key, addr) do
    :ok = send_to_server(struct(Command, [method: :rm, key: key]), addr)
  end

  @spec send_to_server(Command.t(), String.t()) :: :ok | {:error, any()}
  defp send_to_server(command,addr) do

    with {:ok, socket_addr} <- :inet.parse_address(addr),
    {:ok, socket} <- :gen_tcp.connect(addr,[]),
           :ok <- :gen_tcp.send(socket, command |> Jason.encode_to_iodata!),
           :ok <- :gen_tcp.close(socket),
           do: :ok
  end
end
