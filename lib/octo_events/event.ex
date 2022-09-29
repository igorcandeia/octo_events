defmodule OctoEvents.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias OctoEvents.Workers.CloseIssue

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
    |> start_close_job()
    |> build_event()
    |> changeset()
    |> apply_action(:insert)
  end

  # @timezone_fortaleza "America/Fortaleza"

  defp start_close_job(
         %{
           "issue" => %{
             "url" => issue_url,
             "state" => "open"
           }
         } = params
       ) do
    # {:ok, now_timezone_fortaleza} = DateTime.now(@timezone_fortaleza)
    # five_seconds_ago = DateTime.add(now_timezone_fortaleza, 5)
    # IO.inspect(five_seconds_ago)

    %{issue_url: issue_url}
    |> CloseIssue.new()
    |> Oban.insert()

    params
  end

  defp start_close_job(params), do: params

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
    {:ok, rsa_private_key} = ExPublicKey.load(@cert_dir)
    {:ok, rsa_public_key} = ExPublicKey.public_key_from_private_key(rsa_private_key)
    {:ok, username_encrypted} = ExPublicKey.encrypt_public(username, rsa_public_key)
    change(changeset, %{username_encrypted: username_encrypted})
  end

  defp put_username_encrypted(changeset) do
    changeset
  end
end
