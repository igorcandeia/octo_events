defmodule OctoEvents.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :action, :string
    field :created_at, :string
    field :number, :integer
  end

  @required_params [:action, :created_at, :number]

  def build(params) do
    params
    |> build_event()
    |> changeset()
    |> apply_action(:insert)
  end

  defp build_event(%{
         "action" => action,
         "issue" => %{
           "created_at" => created_at,
           "number" => number
         }
       }) do
    %{
      action: action,
      created_at: created_at,
      number: number
    }
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
