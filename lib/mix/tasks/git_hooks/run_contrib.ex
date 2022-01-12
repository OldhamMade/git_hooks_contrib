defmodule Mix.Tasks.GitHooks.RunContrib do
  @shortdoc "Run contributed script given by `name`"

  @moduledoc """
  Run contributed script given by `name`.

  You can run any script by running `mix git_hooks.run hook_name`.

  For example:
  ```elixir
  mix git_hooks.run_contrib example
  ```
  """

  use Mix.Task

  alias GitHooks.Printer

  @doc """
  ### Examples

      iex(1)> Mix.Task.run("git_hooks.run_contrib", ["success-example"])
      :ok
  """
  @impl true
  def run([]), do: error_exit()

  @impl true
  def run(args) do
    {[script_name], args} = Enum.split(args, 1)

    script_name
    |> script_to_module()
    |> check_for_module!()
    |> apply(:run, args)
    |> check_result!()
  end

  defp script_to_module(name) do
    submodule =
      name
      |> String.replace("-", "_")
      |> Macro.camelize()

    Module.concat(GitHooks.Contrib, "#{submodule}")
  end

  defp check_for_module!(name) do
    case Code.ensure_compiled(name) do
      {:module, module} ->
        module

      {:error, _reason} ->
        Printer.error("No contrib script exists matching the name provided.")
        error_exit()
    end
  end

  defp check_result!(:ok), do: :ok
  defp check_result!({:error, _reason}), do: error_exit()

  defp error_exit(error_code \\ {:shutdown, 1}), do: exit(error_code)
end
