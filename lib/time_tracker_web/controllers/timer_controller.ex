defmodule TimeTrackerWeb.TimerController do
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
    case Tracker.create_timer(timer_params) do
      {:ok, timer} ->
        conn
        |> put_flash(:info, "Timer created successfully.")
        |> redirect(to: timer_path(conn, :show, timer))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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