defmodule Cli.Client do
  use ExCLI.DSL,  escript: true,mix_task: :kvs-client
  name "client_cli"
  description "cli for kvs client usage"

  option :version,
  help: "get version"
  aliases: [:v]
  run context do

  end


  command :get do
    description "get key value"
    long_description "send key and get corrodinate value from server"
    argument :key
    option :from, help: "http address of server"
    run context do


    end

  end
  command :set do
    description "get key value"
    long_description "send key and get corrodinate value from server"
    argument :key
    option :from, help: "http address of server"
    run context do
    end
  end
  command :rm do
    description "get key value"
    long_description "send key and get corrodinate value from server"
    argument :key
    option :from, help: "http address of server"
    run context do
    end

  end

  end

defmodule Cli.Server do
  use ExCLI.DSL, escript: true,mix_task: :server
  name "server_cli"
  description "cli for kvs server usage"

  def start_server() do

  end

end
