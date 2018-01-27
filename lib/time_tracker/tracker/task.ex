defmodule TimeTracker.Tracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeTracker.Tracker.Task


  schema "tasks" do
    field :description, :string
    field :name, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
