defmodule OctoEventsWeb.EventView do
  use OctoEventsWeb, :view

  # alias OctoEvents.Event

  # def render("create.json", %{
  #       event: %Event{action: action, created_at: created_at, number: number}
  #     }) do
  #   %{
  #     message: "Event created",
  #     event: %{
  #       action: action,
  #       created_at: created_at,
  #       number: number
  #     }
  #   }
  # end

  # def render("show_events.json", %{events: events}) do
  #   events
  #   |> Enum.map(fn event ->
  #     %{action: event.action, created_at: event.created_at}
  #   end)
  # end

  def render("index.json", %{events: events}) do
    render_many(events, __MODULE__, "create.json")
  end

  def render("create.json", %{event: event}) do
    render_one(event, __MODULE__, "event.json")
  end

  def render("event.json", %{event: event}) do
    %{
      number: event.number,
      action: event.action,
      created_at: event.created_at
    }
  end
end
