defmodule OctoEventsWeb.EventViewTest do
  use OctoEventsWeb.ConnCase, async: true

  import Phoenix.View

  alias OctoEvents.Event

  test "renders create.json" do
    event = %Event{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}
    response = render(OctoEventsWeb.EventView, "create.json", event: event)

    assert %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4} == response
  end

  test "renders show_events.json" do
    events = [%Event{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}]
    response = render(OctoEventsWeb.EventView, "index.json", events: events)

    assert [%{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}] == response
  end
end
