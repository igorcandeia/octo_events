defmodule OctoEvents.Repo.Migrations.CreateEventsTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :action, :string
      add :created_at, :string
      add :number, :integer
    end
  end
end
