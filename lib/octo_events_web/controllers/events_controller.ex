defmodule OctoEventsWeb.EventsController do
  use OctoEventsWeb, :controller

  action_fallback OctoEventsWeb.FallbackController

  def create(conn, params) do
    params
    |> OctoEvents.create_event()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:ok, event}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, event: event)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
