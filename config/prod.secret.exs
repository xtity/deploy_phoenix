use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :deploy_phoenix, DeployPhoenix.Endpoint,
  secret_key_base: "X9NLp5eCqVut1JkavrGHt4N/Z2IsVC/SW8g+UBmXKooK8z5Z3+8wpexqg+5MWatH"

# Configure your database
config :deploy_phoenix, DeployPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "deploy_phoenix_prod"
