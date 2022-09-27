defmodule OctoEvents.Event.Get do
  alias OctoEvents.{Event, Repo}

  import Ecto.Query

  def call(number) do
    number
    |> get()
  end

  defp get(number) do
    case fetch_events(number) do
      nil -> {:error, "Events not found!"}
      events -> {:ok, events}
    end
  end

  defp fetch_events(number) do
    from(e in Event, where: e.number == ^number)
    |> Repo.all()
  end
end
