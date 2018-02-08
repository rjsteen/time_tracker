defmodule TimeTrackerWeb.TimerController do
  require IEx
  use TimeTrackerWeb, :controller

  alias TimeTracker.Tracker
  alias TimeTracker.Tracker.Timer

  def index(conn, _params) do
    timers = Tracker.list_timers()
    render(conn, "index.html", timers: timers)
  end

  def new(conn, _params) do
    changeset = Tracker.change_timer(%Timer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"timer" => timer_params}) do
    project = Tracker.get_project!(conn.params["timer"]["project_id"])
    task = Tracker.get_task!(conn.params["timer"]["task_id"])
    timer_params = %{task_id: task.id, user_id: conn.assigns[:current_user].id}
    case Tracker.create_timer(timer_params) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Time Started")
        |> redirect(to: project_task_path(conn, :index, project))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def stop_timer(conn, _) do
    project = Tracker.get_project!(conn.params["project_id"])
    task = Tracker.get_task!(conn.params["task_id"])
    timer = Tracker.get_started_timer_for_user_and_task(Coherence.current_user(conn).id, task.id)
    duration = NaiveDateTime.diff(NaiveDateTime.utc_now, timer.inserted_at)
    Tracker.update_timer(timer, %{duration: duration})
    redirect(conn, to: project_task_path(conn, :index, project))
  end

  def show(conn, %{"id" => id}) do
    timer = Tracker.get_timer!(id)
    render(conn, "show.html", timer: timer)
  end

  def edit(conn, %{"id" => id}) do
    timer = Tracker.get_timer!(id)
    changeset = Tracker.change_timer(timer)
    render(conn, "edit.html", timer: timer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "timer" => timer_params}) do
    timer = Tracker.get_timer!(id)

    case Tracker.update_timer(timer, timer_params) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer updated successfully.")
        |> redirect(to: timer_path(conn, :show, timer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", timer: timer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timer = Tracker.get_timer!(id)
    {:ok, _timer} = Tracker.delete_timer(timer)

    conn
    |> put_flash(:info, "Timer deleted successfully.")
    |> redirect(to: timer_path(conn, :index))
  end
end
