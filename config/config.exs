import Config

# if you already have a config file, then you'll just need to add this:
config :ash, :use_all_identities_in_manage_relationship?, false

config :helpdesk,
  ash_apis: [Helpdesk.Support]

config :helpdesk,
  ecto_repos: [Helpdesk.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
