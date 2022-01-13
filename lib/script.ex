defmodule GitHooks.Contrib.Script do
  @moduledoc """
  Behaviour for scripts by git_hooks_contrib.
  """

  @callback run(args :: term) :: :ok | {:error, reason :: term}
  @callback run() :: :ok | {:error, reason :: term}
end
