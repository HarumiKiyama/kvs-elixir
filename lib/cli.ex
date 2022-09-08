defmodule Cli.Client do
  def main(argv) do
    Optimus.new!(
      name: "kvs-client",
      description: "kvs client cli",
      version: "1.0.0",
      author: "harumi <lucius0720@hotmail.com>",
      allow_unknown_args: false,
      parse_double_dash: true,
      options: [
        addr: [
          value_name: "ADDR",
          long: "--addr",
          help: "server address",
          required: false,
          parser: :string
        ]
      ],
      subcommands: [
        get: [
          name: "get",
          about: "get key value from server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ]
          ]
        ],
        set: [
          name: "set",
          about: "set key value on server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ],
            value: [
              value_name: "VALUE",
              required: true,
              parser: :string
            ]
          ]
        ],
        rm: [
          name: "rm",
          about: "remove key on server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ]
          ]
        ]
      ]
    )
    |> Optimus.parse!(argv)
    |> IO.inspect()
  end
end

defmodule Cli.Server do
  def main(argv) do
    Optimus.new!(
      name: "kvs-client",
      description: "kvs client cli",
      version: "1.0.0",
      author: "harumi <lucius0720@hotmail.com>",
      allow_unknown_args: false,
      parse_double_dash: true,
      options: [
        addr: [
          value_name: "ADDR",
          long: "--addr",
          help: "server address",
          required: false,
          parser: :string
        ]
      ],
      subcommands: [
        get: [
          name: "get",
          about: "get key value from server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ]
          ]
        ],
        set: [
          name: "set",
          about: "set key value on server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ],
            value: [
              value_name: "VALUE",
              required: true,
              parser: :string
            ]
          ]
        ],
        rm: [
          name: "rm",
          about: "remove key on server",
          args: [
            key: [
              value_name: "KEY",
              required: true,
              parser: :string
            ]
          ]
        ]
      ]
    )
    |> Optimus.parse!(argv)
    |> IO.inspect()
  end
end
