defmodule OctoEvents do
  alias OctoEvents.Event

  defdelegate create_event(params), to: Event.Create, as: :call

  defdelegate fetch_events_by_number(params), to: Event.Get, as: :call
end
