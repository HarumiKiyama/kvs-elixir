defmodule Command do
  defstruct [:method, :key, :val]
  @type method :: :get | :set | :rm
end
