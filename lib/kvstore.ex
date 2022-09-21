defmodule Kvstore do
  def start_link do
    Agent.start_link(fn -> Map.new() end)
  end

  def set(key, val, agent, file) do
    {:ok, start_pos} = :file.position(file, :eof)
    {:ok, command} = struct(Command, method: :set, key: key, val: val) |> Jason.encode()
    :ok = :file.write(file, command)
    {:ok, end_pos} = :file.position(file, :cur)
    IO.inspect([start_pos, end_pos])
    Agent.update(agent, &Map.put(&1, key, {start_pos, end_pos}))
  end

  def get(key, agent, file) do
    {start_pos, end_pos} = Agent.get(agent, &Map.get(&1, key))
    IO.inspect([start_pos, end_pos])
    {:ok, _} = :file.position(file, start_pos)
    {:ok, data} = :file.read(file, end_pos - start_pos)
    {:ok, command} = Jason.decode(data, [keys: :atoms!])
    struct(Command, command)
  end

  def remove(key, agent, file) do
    {:ok, _} = :file.position(file, :cur)
    {:ok, command} = struct(Command, method: :rm, key: key) |> Jason.encode()
    :ok = :file.write(file, command)
    Agent.get_and_update(agent, &Map.pop!(&1, key))
  end
end
