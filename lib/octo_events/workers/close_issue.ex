defmodule OctoEvents.Workers.CloseIssue do
  use Oban.Worker

  alias OctoEvents.GithubApi.Client

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"issue_url" => issue_url}}) do
    Client.close_issue(issue_url)
  end
end
