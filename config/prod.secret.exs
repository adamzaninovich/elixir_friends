use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :elixir_friends, ElixirFriends.Endpoint,
  secret_key_base: "tpn+HxgRvjPexTeVWsD9KGyDSlQ3xtQO4qCL9SIo0Pg4hqtN3pR0fnyobUQJJ49o"

# Configure your database
config :elixir_friends, ElixirFriends.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL")
