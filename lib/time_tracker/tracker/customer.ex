defmodule TimeTracker.Tracker.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeTracker.Tracker.Customer


  schema "customers" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
