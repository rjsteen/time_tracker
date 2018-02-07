defmodule TimeTrackerWeb.TaskView do
  require IEx
  use TimeTrackerWeb, :view
  alias TimeTracker.Tracker

  def user_started_timer?(conn) do
    Tracker.get_started_timer_for_user(Coherence.current_user(conn).id)
  end
end
