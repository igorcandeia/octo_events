defmodule OctoEvents.Event.GetTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{Event, Repo}
  alias Event.{Create, Get}

  describe "call/1" do
    test "when the event number exists, returns a list of events with that number" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4, username: "testuser"}
      Create.call(params)
      Create.call(params)
      count_after = Repo.aggregate(Event, :count) # 2 in this case, because last 2 lines insertions

      response = Get.call(params.number)

      assert {:ok, events} = response
      assert count_after == length(events)
      assert %Event{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4} = hd(events)
    end

    test "when the event number does not exists, returns an empty list" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4, username: "testuser"}
      Create.call(params)

      response = Get.call(9) # invalid number 9

      assert {:ok, events} = response
      assert Enum.empty?(events) # the list is empty
    end

    test "when the param is invalid, returns an error" do
      params = %{action: "closed", created_at: "2022-09-26T18:21:21Z", number: 4, username: "testuser"}
      Create.call(params)

      response = Get.call("a") # invalid number 9

      assert {:error, "'a' is not a number"} = response
    end
  end
end
