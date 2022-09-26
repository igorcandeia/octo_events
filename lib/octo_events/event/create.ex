defmodule OctoEvents.Event.Create do
  alias OctoEvents.{Event, Repo}

  def call(params) do
    params
    |> Event.build()
    |> create_event()
  end

  defp create_event({:ok, struct}), do: Repo.insert(struct)
  defp create_event({:error, _changeset} = error), do: error
end
