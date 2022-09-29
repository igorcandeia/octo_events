defmodule OctoEvents.GithubApi.Client do
  use Tesla

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.BearerAuth, token: "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"
  plug Tesla.Middleware.Headers, [{"User-Agent", "octo_events"}]

  def close_issue(issue_url) do
    issue_url
    |> patch(%{state: "closed"})
    |> handle_patch()
  end

  defp handle_patch({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_patch({:ok, %Tesla.Env{status: 404, body: error}}), do: {:error, error}
  defp handle_patch({:ok, %Tesla.Env{status: 403, body: error}}), do: {:error, error}
  defp handle_patch({:error, _reason} = error), do: error
end
