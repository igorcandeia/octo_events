defmodule OctoEvents.Repo.Migrations.AddColumnUsernameEncrypted do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :username_encrypted, :text
    end
  end
end
