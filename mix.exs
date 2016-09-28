defmodule Timber.Mixfile do
  use Mix.Project

  @project_description """
  Timber is a specialized logging engine for Elixir built to contextualize
  logs for use with the Timber.io service. Out-of-the-box, Timber supports
  contextualizing logs for Plug-based frameworks with specific support
  for Phoenix and Ecto planned.
  """

  @source_url "https://github.com/timberio/timber-elixir"
  @homepage_url "https://github.com/timberio/timber-elixir"
  @version "0.1.0"

  # Project manifest for Mix
  #
  # See `mix help` entries for the following if you need
  # more information about the options used in this section:
  #
  #   - `compile`
  #   - `compile.elixir`
  #   - `compile.erlang`
  def project do
    [
      app: :timber,
      name: "Timber",
      version: @version,
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      description: @project_description,
      source_url: @source_url,
      homepage_url: @homepage_url,
      package: package,
      deps: deps(),
      docs: docs(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      preferred_cli_env: preferred_cli_env(),
      test_coverage: test_coverage()
    ]
  end

  # Appication definition for building the `.app` file
  #
  # See `mix help compile.app` for more information about the
  # options used in this section
  #
  # Note: Because this is a package, the default environment
  # is specified in this section. The `config/*` files in this
  # repository are only useful for this package's local development
  # and are not distributed with the package.
  def application do
    [
      applications: apps(Mix.env)
    ]
  end

  # List of applications to be loaded for the specified
  # Mix environment.
  defp apps(:test), do: apps()
  defp apps(_), do: apps()

  # Default list of applications to be loaded regardless
  # of Mix environment
  defp apps(), do: [:logger]

  # Compiler paths switched on the Mix environment
  #
  # The `lib` directory is always compiled
  #
  # In the :test environment, `test/support` will also be compiled
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Preferred CLI Environment details
  #
  # Defines the preferred environment for Mix tasks
  defp preferred_cli_env() do
    [
      "coveralls": :test,
      "coveralls.details": :test,
      "coveralls.circle": :test,
      "coveralls.html": :test
    ]
  end

  # Test Coverage configuration
  #
  # Sets the test converage tool to be Coveralls
  defp test_coverage() do
    [
      tool: ExCoveralls
    ]
  end

  # Package options for the Hex package listing
  #
  # See `mix help hex.publish` for more information about
  # the options used in this section
  defp package() do
    [
      name: :timber,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Ben Johnson", "David Antaramian"],
      licenses: ["Timber Technologies License"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  # Documentation options for ExDoc
  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: [
        "README.md": [title: "README"]
      ]
    ]
  end

  # Dependencies for this application
  #
  # See `mix help deps` for more information about the options used
  # in this section
  #
  # Please:
  #
  #   - Keep this as the last section in `mix.exs` to make
  #     it easily discoverable
  #   - Keep this section sorted in alphabetical order
  defp deps do
    [
      {:credo, "~> 0.4", only: [:dev, :test]},
      {:dialyxir, "~> 0.3", only: [:dev, :test]},
      {:earmark, "~> 1.0", only: [:dev, :docs]},
      {:ex_doc, "~> 0.13", only: [:dev, :docs]},
      {:excoveralls, "~> 0.5", only: [:test]},
      {:poison, "~> 2.2.0"},
    ]
  end
end
