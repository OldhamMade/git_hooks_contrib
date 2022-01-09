defmodule GitHooks.Contrib.PreventBrokenSymlinks do
  @moduledoc """
  Recursively checks a directory for broken symlinks.

  For example:
  ```elixir
  config :git_hooks,
    hooks: [
      pre_commit: [
        {:mix_task, :"git_hooks.run_contrib", ["prevent-broken-symlinks"]}
      ]
    ]
  ```
  """

  @behaviour GitHooks.Contrib.Script

  alias GitHooks.Printer

  @doc """
  Check given paths (default: the project's root) for broken symlinks.

  This function accepts a list of paths to check.
  """
  @impl true
  def run([_ | _] = args) do
    args
    |> find_files()
    |> report()
  end

  @impl true
  def run(arg), do: run([arg])

  @impl true
  def run, do: run([File.cwd!()])

  defp find_files(paths) do
    for path <- paths do
      case File.stat(path) do
        {:error, :enoent} ->
          path

        {:ok, %File.Stat{type: :directory}} ->
          with {:ok, files} <- File.ls(path) do
            files
            |> Enum.map(&Path.join(path, &1))
            |> find_files()
          end

        {:ok, _} ->
          nil
      end
    end
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end

  defp report([]) do
    Printer.success("No broken symlinks found.")
    :ok
  end

  defp report(paths) do
    broken =
      paths
      |> Enum.join("\n  - ")

    Printer.error("Broken symlinks found:\n  - #{broken}")

    {:error, "Broken symlinks found: #{inspect(paths)}"}
  end
end
