defmodule ExAws.CognitoIdentity.Mixfile do
  use Mix.Project

  @version "1.2.0"
  @url_github "https://github.com/jessek1/ex_aws_cognito_identity"

  def project do
    [
      app: :ex_aws_cognito_identity,
      name: "ExAws.CognitoIdentity",
      description: "ExAws.Cognito Federated Identities service package",
      package: %{
        files: [
          "lib",
          "config",
          "mix.exs",
          "README*"
        ],
        licenses: [ "MIT" ],
        links: %{
          #"Docs" => @url_docs,
          github: @url_github
        },
        maintainers: ["Jesse Keane"]
      },
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env == :prod,
      deps: deps(),
      source_url: @url_github,
      homepage_url: @url_github
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib",]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:hackney, ">= 0.0.0", only: [:dev, :test]},
      {:sweet_xml, ">= 0.0.0", only: [:dev, :test]},
      {:jason, ">= 0.0.0", only: [:dev, :test]},
      ex_aws(),
    ]
  end

  defp ex_aws() do
    case System.get_env("AWS") do
      "LOCAL" -> {:ex_aws, path: "../ex_aws"}
      _ -> {:ex_aws, "~> 2.0"}
    end
  end
end
