defmodule OctoEvents.GithubApi.ClientTest do
  use ExUnit.Case, async: true

  alias OctoEvents.GithubApi.Client

  setup do
    Tesla.Mock.mock(fn env ->
      case env.url do
        "https://api.github.com/repos/igorcandeia/octo_events/issues/8" ->
          %Tesla.Env{status: 200, body: "ok!"}

        _ ->
          %Tesla.Env{status: 404, body: "NotFound"}
      end
    end)

    :ok
  end

  test "when the url is valid, returns :ok body" do
    assert {:ok, body} = Client.close_issue("https://api.github.com/repos/igorcandeia/octo_events/issues/8")
    assert body == "ok!"
  end

  test "when the url is not valid, return :error body" do
    assert {:error, body} = Client.close_issue("https://api.github.com/repos/igorcandeia/octo_events/issues/99")
    assert body == "NotFound"
  end
end
