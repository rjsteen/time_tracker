defmodule TimeTracker.Tracker.Timer do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeTracker.Tracker.Timer


  schema "timers" do
    field :duration, :integer
    field :stopped_at, :naive_datetime
    field :user_id, :id
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Timer{} = timer, attrs) do
    timer
    |> cast(attrs, [:stopped_at, :duration])
    |> validate_required([:stopped_at, :duration])
  end
end
