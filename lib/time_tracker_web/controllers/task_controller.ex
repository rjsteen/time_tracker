defmodule TimeTrackerWeb.TaskController do
  use TimeTrackerWeb, :controller

  alias TimeTracker.Tracker
  alias TimeTracker.Tracker.Task

  def index(conn, _params, project) do
    tasks = Tracker.list_tasks()
    render(conn, "index.html", tasks: tasks, project: project)
  end

  def new(conn, _params, project) do
    changeset = Tracker.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, project: project)
  end

  def create(conn, %{"task" => task_params}, project) do
    case Tracker.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: project_task_path(conn, :show, project, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, project: project)
    end
  end

  def show(conn, %{"id" => id}, project) do
    task = Tracker.get_task!(id)
    render(conn, "show.html", task: task, project: project)
  end

  def edit(conn, %{"id" => id}, project) do
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, project: project)
  end

  def update(conn, %{"id" => id, "task" => task_params}, project) do
    task = Tracker.get_task!(id)

    case Tracker.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: project_task_path(conn, :show, project, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, project: project)
    end
  end

  def delete(conn, %{"id" => id}, project) do
    task = Tracker.get_task!(id)
    {:ok, _task} = Tracker.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: project_task_path(conn, :index, project))
  end

  defp action(conn, _) do
    project = Tracker.get_project!(conn.params["project_id"])
    args = [conn, conn.params, project]
    apply(__MODULE__, action_name(conn), args)
  end
end
