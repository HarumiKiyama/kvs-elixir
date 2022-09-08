defmodule KvsElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :kvs_elixir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Cli.Client],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [],
      registered: [KvServer]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:optimus, "~> 0.2"},
      {:jason, "~>1.3"}
    ]
  end

end
