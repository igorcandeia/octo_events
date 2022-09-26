defmodule OctoEventsWeb.PayloadController do
  use OctoEventsWeb, :controller

  def index(conn, params) do
    conn
    |> put_status(:ok)
    |> json(params)
  end
end
