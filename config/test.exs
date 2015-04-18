use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deploy_phoenix, DeployPhoenix.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :deploy_phoenix, DeployPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "deploy_phoenix_test",
  size: 1,
  max_overflow: false
