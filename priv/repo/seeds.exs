# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeTracker.Repo.insert!(%TimeTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
TimeTracker.Repo.delete_all TimeTracker.Coherence.User

TimeTracker.Coherence.User.changeset(%TimeTracker.Coherence.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> TimeTracker.Repo.insert!
