defmodule TimeTrackerWeb.TaskView do
  require IEx
  use TimeTrackerWeb, :view
  alias TimeTracker.Tracker

  def user_started_timer?(conn, task) do
    Tracker.get_started_timer_for_user_and_task(Coherence.current_user(conn).id, task.id)
  end
end
