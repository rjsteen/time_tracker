defmodule TimeTracker.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string
      add :customer_id, references(:customers, on_delete: :delete_all)

      timestamps()
    end

    create index(:projects, [:customer_id])
  end
end
