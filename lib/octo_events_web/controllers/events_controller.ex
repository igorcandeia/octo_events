defmodule OctoEventsWeb.EventsController do
  use OctoEventsWeb, :controller

  action_fallback OctoEventsWeb.FallbackController

  def create(conn, params) do
    params
    |> OctoEvents.create_event()
    |> handle_create_response(conn)
  end

  defp handle_create_response({:ok, event}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", event: event)
  end

  defp handle_create_response({:error, _changeset} = error, _conn), do: error

  def show(conn, %{"number" => number}) do
    number
    |> OctoEvents.fetch_events_by_number()
    |> handle_show_response(conn)
  end

  defp handle_show_response({:ok, events}, conn) do
    conn
    |> put_status(:ok)
    |> render("show_events.json", events: events)
  end

  defp handle_show_response({:error, _events} = error, _conn), do: error

end
