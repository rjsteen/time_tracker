defmodule TimeTrackerWeb.TimerControllerTest do
  use TimeTrackerWeb.ConnCase

  alias TimeTracker.Tracker

  @create_attrs %{duration: 42, stopped_at: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{duration: 43, stopped_at: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{duration: nil, stopped_at: nil}

  def fixture(:timer) do
    {:ok, timer} = Tracker.create_timer(@create_attrs)
    timer
  end

  describe "index" do
    test "lists all timers", %{conn: conn} do
      conn = get conn, timer_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Timers"
    end
  end

  describe "new timer" do
    test "renders form", %{conn: conn} do
      conn = get conn, timer_path(conn, :new)
      assert html_response(conn, 200) =~ "New Timer"
    end
  end

  describe "create timer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, timer_path(conn, :create), timer: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == timer_path(conn, :show, id)

      conn = get conn, timer_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Timer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, timer_path(conn, :create), timer: @invalid_attrs
      assert html_response(conn, 200) =~ "New Timer"
    end
  end

  describe "edit timer" do
    setup [:create_timer]

    test "renders form for editing chosen timer", %{conn: conn, timer: timer} do
      conn = get conn, timer_path(conn, :edit, timer)
      assert html_response(conn, 200) =~ "Edit Timer"
    end
  end

  describe "update timer" do
    setup [:create_timer]

    test "redirects when data is valid", %{conn: conn, timer: timer} do
      conn = put conn, timer_path(conn, :update, timer), timer: @update_attrs
      assert redirected_to(conn) == timer_path(conn, :show, timer)

      conn = get conn, timer_path(conn, :show, timer)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, timer: timer} do
      conn = put conn, timer_path(conn, :update, timer), timer: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Timer"
    end
  end

  describe "delete timer" do
    setup [:create_timer]

    test "deletes chosen timer", %{conn: conn, timer: timer} do
      conn = delete conn, timer_path(conn, :delete, timer)
      assert redirected_to(conn) == timer_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, timer_path(conn, :show, timer)
      end
    end
  end

  defp create_timer(_) do
    timer = fixture(:timer)
    {:ok, timer: timer}
  end
end
