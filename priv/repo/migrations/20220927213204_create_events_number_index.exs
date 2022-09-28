defmodule OctoEvents.Repo.Migrations.CreateEventsNumberIndex do
  use Ecto.Migration

  def change do
    create index(:events, [:number])
  end
end
