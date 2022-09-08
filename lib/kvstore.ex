defmodule Kvstore do
  def set(key, val, map, file) do
    {:ok, start_pos} = :file.position(file, :cur)
    command = struct(Command, %{"method"=> :set, "key" => key, "val" => val})
    :ok = :file.write(file, command |> )
    {:ok, end_pos} = :file.position(file, :cur)
    %{map | key => {start_pos, end_pos}}
  end

  def get(key, map, file) do
    {start_pos, end_pos} = map[key]
    {:ok, _} = :file.position(file, start_pos)
    {:ok, data} = :file.read(file, end_pos-start_pos)
    data
  end

  def remove(key, map, file_path) do
    Map.pop!(map,key)
  end

  def compact() do

  end
end
