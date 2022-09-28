defmodule OctoEventsWeb.EventsControllerTest do
  use OctoEventsWeb.ConnCase

  describe "show/2" do
    test "when there is events with given number, returns a list of events", %{conn: conn} do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}
      OctoEvents.create_event(params)

      params = %{action: "opened", created_at: "2022-09-26T18:21:21Z", number: 5}
      OctoEvents.create_event(params)

      response =
        conn
        |> get(Routes.events_path(conn, :show, 4))
        |> json_response(:ok)

      assert [%{"action" => "closed", "created_at" => "2022-09-26T18:21:21Z"}] == response
    end

    test "when receive an invalid number, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.events_path(conn, :show, "a"))
        |> json_response(:bad_request)

      assert %{"message" => "'a' is not a number"} == response
    end
  end

  describe "create/2" do
    test "when receive an event by post, saves that and returns the event", %{conn: conn} do
      params = %{"action" => "closed", "created_at" => "2022-09-26T18:21:21Z", "number" => 4}

      response =
        conn
        |> post(Routes.events_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "Event created", "trainer" => %{"action" => "closed", "created_at" => "2022-09-26T18:21:21Z", "number" => 4}} == response
    end

    test "when receive an invalid body, returns the error", %{conn: conn} do
      params = %{"action" => "closed", "created_at" => "2022-09-26T18:21:21Z"}

      response =
        conn
        |> post(Routes.events_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"errors" => %{"number" => "can't be blank"}} == response
    end
  end
end
