defmodule Kvsclient do
  def get(key, addr) do
    with :ok <- send_to_server(struct(Command, method: :get, key: key), addr),
      do: :ok
  end

  def set(key, val, addr) do
    with :ok <- send_to_server(struct(Command, method: :set, key: key, val: val), addr),
      do: :ok
  end

  def rm(key, addr) do
    with :ok <- send_to_server(struct(Command, method: :rm, key: key), addr),
      do: :ok
  end

  @spec send_to_server(Command.t(), String.t() | nil) :: :ok | {:error, any()}

  defp send_to_server(command, nil) do
    send_to_server(command, "127.0.0.1:4040")
  end

  defp send_to_server(command, addr) do
    with [ip, port] <- String.split(addr, ":"),
         {:ok, socket_addr} <- :inet.parse_address(String.to_charlist(ip)),
         {port, _} <- Integer.parse(port),
         {:ok, socket} <- :gen_tcp.connect(socket_addr, port, []),
         :ok <- :gen_tcp.send(socket, command |> Jason.encode_to_iodata!()),
         :ok <- :gen_tcp.close(socket),
         do: :ok
  end
end
