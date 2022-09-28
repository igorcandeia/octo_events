defmodule OctoEventsWeb.EventsView do
  use OctoEventsWeb, :view

  alias OctoEvents.Event

  def render("create.json", %{
        event: %Event{action: action, created_at: created_at, number: number}
      }) do
    %{
      message: "Event created",
      trainer: %{
        action: action,
        created_at: created_at,
        number: number
      }
    }
  end

  def render("show_events.json", %{events: events}) do
    events
    |> Enum.map(fn event ->
      %{action: event.action, created_at: event.created_at}
    end)
  end
end
