defmodule EsClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :es_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EsClient, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:eventsource_ex, "~> 0.0.2"},
      {:poison, "~> 3.1"}
    ]
  end
end
