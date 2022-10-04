defmodule OctoEvents.Event.CreateTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{Event, Repo}
  alias Event.Create

  describe "call/1" do
    test "when all params are valid, creates an event" do
      params = %{
        action: "closed",
        created_at: "2022-09-26T18:21:21Z",
        number: 4,
        username: "testuser"
      }

      count_before = Repo.aggregate(Event, :count)

      {:ok, response} = Create.call(params)

      count_after = Repo.aggregate(Event, :count)
      cert_dir = "#{File.cwd!()}/test_rsa_private_key.pem"
      {:ok, rsa_private_key} = ExPublicKey.load(cert_dir)

      {:ok, expected_username} =
        ExPublicKey.decrypt_private(response.username_encrypted, rsa_private_key)

      assert expected_username == params.username

      assert %Event{
               action: "closed",
               created_at: "2022-09-26T18:21:21Z",
               number: 4,
               username: "testuser"
             } = response

      assert count_before < count_after
    end

    test "when there are invalid or is missing params, returns an error" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", username: "testuser"}

      response = Create.call(params)

      assert {:error, changeset} = response
      # One way to test using errors_on
      assert %{number: ["can't be blank"]} == errors_on(changeset)
    end
  end
end
