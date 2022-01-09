defmodule GitHooks.Contrib.SuccessExample do
  @moduledoc """
  Example script, returns `:ok`

  For example:
  ```elixir
  config :git_hooks,
    hooks: [
      pre_commit: [
        {:mix_task, :"git_hooks.run_contrib", ["success-example"]}
      ]
    ]
  ```
  """

  @behaviour GitHooks.Contrib.Script

  @doc """
  Return `:ok`.
  """
  @impl true
  def run, do: :ok

  @impl true
  def run(_args), do: :ok
end
