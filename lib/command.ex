defmodule Command do
  @type t :: %__MODULE__{
          method: :get | :set | :rm,
          key: String.t(),
          val: String.t() | nil
  }
  @derive Jason.Encoder
  defstruct [:method, :key, :val]
end
