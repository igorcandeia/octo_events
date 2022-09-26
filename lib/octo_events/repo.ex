defmodule OctoEvents.Repo do
  use Ecto.Repo,
    otp_app: :octo_events,
    adapter: Ecto.Adapters.Postgres
end
