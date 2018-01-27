defmodule TimeTracker.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
