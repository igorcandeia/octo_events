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
end
