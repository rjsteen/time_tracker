defmodule TimeTracker.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :stopped_at, :naive_datetime
      add :duration, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all)
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:timers, [:user_id])
    create index(:timers, [:task_id])
  end
end
