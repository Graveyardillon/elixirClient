use Mix.Config

config :httpclient, Users.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "httpclient_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


config :httpclient, Httpclient.Endpoint, port: 4000
config :httpclient, redirect_url: "https://elixir-http-coient.herokuapp.com/hello"

import_config "#{Mix.env()}.exs"
