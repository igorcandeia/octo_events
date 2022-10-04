defmodule OctoEvents.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :action, :string
    field :created_at, :string
    field :number, :integer
    field :username_encrypted, :string
    field :username, :string, virtual: true
  end

  @required_params [:action, :created_at, :number, :username]
  @cert_dir "#{File.cwd!()}/test_rsa_private_key.pem"

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
           "number" => number,
           "user" => %{"login" => username}
         }
       }) do
    %{
      action: action,
      created_at: created_at,
      number: number,
      username: username
    }
  end

  defp build_event(invalid_body), do: invalid_body

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_username_encrypted()
  end

  defp put_username_encrypted(
         %Ecto.Changeset{valid?: true, changes: %{username: username}} = changeset
       ) do
    with {:ok, rsa_private_key} <- ExPublicKey.load(@cert_dir),
         {:ok, rsa_public_key} <- ExPublicKey.public_key_from_private_key(rsa_private_key),
         {:ok, username_encrypted} <- ExPublicKey.encrypt_public(username, rsa_public_key) do
      change(changeset, %{username_encrypted: username_encrypted})
    else
      {:error, _} ->
        add_error(changeset, :username_encrypted, "Error on encrypt username")
    end
  end

  defp put_username_encrypted(changeset) do
    changeset
  end
end
