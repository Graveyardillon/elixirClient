use Mix.Config

config :httpclient, Httpclient.Endpoint, port: 4000
config :httpclient, redirect_url: "https://elixir-http-coient.herokuapp.com/hello"

import_config "#{Mix.env()}.exs"
