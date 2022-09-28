defmodule OctoEvents.Event.CreateTest do
  use OctoEvents.DataCase

  alias OctoEvents.{Event, Repo}
  alias Event.Create

  describe "call/1" do
    test "when all params are valid, creates an event"  do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}

      count_before = Repo.aggregate(Event, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Event, :count)

      assert {:ok, %Event{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4}} = response
      assert count_before < count_after
    end

    test "when there are invalid or is missing params, returns an error"  do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z"}

      response = Create.call(params)

      assert {:error, changeset} = response
      # One way to test using errors_on
      assert %{number: ["can't be blank"]} == errors_on(changeset)
    end
  end
end
