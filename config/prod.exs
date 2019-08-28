use Mix.Config

config :httpclient, Httpclient.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")

config :httpclient, redirect_url: System.get_env("REDIRECT_URL")
