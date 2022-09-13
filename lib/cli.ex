defmodule Cli.Client do
  def main(argv) do
    args =
      Optimus.new!(
        name: "kvs-client",
        description: "kvs client cli",
        version: "1.0.0",
        author: "harumi <lucius0720@hotmail.com>",
        allow_unknown_args: false,
        parse_double_dash: true,
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
            ],
            options: [
              addr: [
                value_name: "ADDR",
                long: "--addr",
                help: "server address",
                required: false,
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
            ],
            options: [
              addr: [
                value_name: "ADDR",
                long: "--addr",
                help: "server address",
                required: false,
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
            ],
            options: [
              addr: [
                value_name: "ADDR",
                long: "--addr",
                help: "server address",
                required: false,
                parser: :string
              ]
            ]
          ]
        ]
      )
      |> Optimus.parse!(argv)

    case args do
      {[:get], remain} -> get(remain)
      {[:rm], remain} -> rm(remain)
      {[:set], remain} -> set(remain)
      _ -> IO.puts("wrong method")
    end
  end

  def get(args) do
    %{addr: addr} = args.options
    %{key: key} = args.args
    Kvsclient.get(key, addr)
  end

  def set(args) do
    %{addr: addr} = args.options
    %{key: key, val: val} = args.args
    Kvsclient.set(key, val, addr)
  end

  def rm(args) do
    %{addr: addr} = args.options
    %{key: key} = args.args
    Kvsclient.rm(key, addr)
  end
end
