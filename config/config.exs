# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :time_tracker,
  ecto_repos: [TimeTracker.Repo]

# Configures the endpoint
config :time_tracker, TimeTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TpzRnSuPzwi6gg+q1l/dgiPsFv9T/WwsLRifGL91eCB1TKOqBa7ZupZd0PnUaG1/",
  render_errors: [view: TimeTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TimeTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: TimeTracker.Coherence.User,
  repo: TimeTracker.Repo,
  module: TimeTracker,
  web_module: TimeTrackerWeb,
  router: TimeTrackerWeb.Router,
  messages_backend: TimeTrackerWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, TimeTrackerWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
