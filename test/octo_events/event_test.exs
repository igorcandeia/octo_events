defmodule OctoEvents.EventTest do
  use OctoEvents.DataCase

  alias OctoEvents.Event

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}
      response = Event.changeset(params)

      assert %Ecto.Changeset{
               changes: %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4},
               errors: [],
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z"}
      response = Event.changeset(params)

      assert %Ecto.Changeset{
               changes: %{action: "closed", created_at: "2022-09-26T18:21:21Z"},
               errors: [number: {"can't be blank", [validation: :required]}],
               valid?: false
             } = response

      assert %{number: ["can't be blank"]} == errors_on(response)
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a event struct" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}
      response = Event.build(params)

      assert {:ok,
              %Event{
                action: "closed",
                created_at: "2022-09-26T18:21:21Z",
                id: nil,
                number: 4
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z"}
      response = Event.build(params)

      assert {:error,
              %Ecto.Changeset{
                action: :insert,
                changes: %{action: "closed", created_at: "2022-09-26T18:21:21Z"},
                errors: [number: {"can't be blank", [validation: :required]}],
                valid?: false
              }} = response
    end
  end
end
