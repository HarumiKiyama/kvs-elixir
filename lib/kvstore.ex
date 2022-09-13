defmodule Kvstore do
  def set(key, val, map, file) do
    {:ok, start_pos} = :file.position(file, :cur)
    {:ok, command} = struct(Command, [method: :set, key: key, val: val]) |> Jason.encode()
    :ok = :file.write(file, command)
    {:ok, end_pos} = :file.position(file, :cur)
    %{map | key => {start_pos, end_pos}}
  end

  def get(key, map, file) do
    {start_pos, end_pos} = map[key]
    {:ok, _} = :file.position(file, start_pos)
    {:ok, data} = :file.read(file, end_pos-start_pos)
    {:ok, command} = Jason.decode(data)
    command
  end

  def remove(key, map, file) do
    {:ok, _} = :file.position(file, :cur)
    {:ok, command} = struct(Command, [method: :rm, key: key]) |> Jason.encode()
    :ok = :file.write(file, command)
    Map.pop!(map,key)
  end


end
