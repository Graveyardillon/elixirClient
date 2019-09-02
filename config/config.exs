use Mix.Config

config :httpclient, Httpclient.Users.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "httpclient_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"


config :httpclient, Httpclient.Endpoint, port: 4000
config :httpclient, redirect_url: "https://elixir-http-coient.herokuapp.com/hello"

import_config "#{Mix.env()}.exs"
config :httpclient, ecto_repos: [Users.Repo]
