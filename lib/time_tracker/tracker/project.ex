defmodule TimeTracker.Tracker.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeTracker.Tracker.Project


  schema "projects" do
    field :description, :string
    field :name, :string
    field :customer_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
