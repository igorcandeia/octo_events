defmodule OctoEvents.Event.Get do
  alias OctoEvents.{Event, Repo}

  import Ecto.Query

  def call(number) when is_integer(number), do: get(number)

  def call(number) do
    case Integer.parse(number) do
      :error -> {:error, "'#{number}' is not a number"}
      {n, _} -> get(n)
    end
  end

  defp get(number) do
    case fetch_events(number) do
      nil -> {:error, "Events not found!"}
      events -> {:ok, events}
    end
  end

  defp fetch_events(number) do
    Event
    |> where(number: ^number)
    |> Repo.all()
  end
end
