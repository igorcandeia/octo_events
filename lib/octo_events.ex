defmodule OctoEvents do
  alias OctoEvents.Event

  defdelegate create_event(params), to: Event.Create, as: :call
end
