defmodule OctoEvents.Workers.CloseIssueTest do
  use ExUnit.Case, async: true
  use Mimic

  alias OctoEvents.Workers.CloseIssue
  alias OctoEvents.GithubApi.Client

  test "when the worker receive a valid issue url, returns :ok" do
    Client
    |> expect(:close_issue, fn url -> {:ok, url} end)

    oban_job = %Oban.Job{args: %{"issue_url" => "valid_issue_url"}}
    assert {:ok, "valid_issue_url"} == CloseIssue.perform(oban_job)
  end
end
