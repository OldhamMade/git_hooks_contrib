defmodule GitHooks.Contrib.Script do
  @callback run(args :: term) :: :ok | {:error, reason :: term}
  @callback run() :: :ok | {:error, reason :: term}
end
