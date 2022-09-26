defmodule OctoEventsWeb.FallbackController do
  use OctoEventsWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(OctoEventsWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
