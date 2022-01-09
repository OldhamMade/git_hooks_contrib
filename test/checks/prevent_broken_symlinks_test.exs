defmodule GitHooks.Contrib.PreventBrokenSymlinksTest do
  use ExUnit.Case

  import ExUnit.Quiet

  alias GitHooks.Contrib.PreventBrokenSymlinks

  setup do
    {:ok, tmpdir} = Temp.mkdir("git-hooks-contrib-test")

    on_exit(fn ->
      File.rmdir(tmpdir)
    end)

    [testdir: tmpdir]
  end

  test "raises for broken symlinks", context do
    target = context[:testdir]

    System.cmd("ln", ["-sf", "missing-file", "broken-link"], cd: target)

    quiet do
      assert {:error, _} = PreventBrokenSymlinks.run([target])
    end
  end

  test "successful for valid symlinks", context do
    target = context[:testdir]

    System.cmd("touch", ["existing-file"], cd: target)
    System.cmd("ln", ["-sf", "existing-file", "valid-link"], cd: target)

    quiet do
      assert :ok = PreventBrokenSymlinks.run([target])
    end
  end

  test "handles multiple paths correctly", context do
    parent = context[:testdir]
    targets = [Path.join(parent, "subdir_a"), Path.join(parent, "subdir_b")]

    System.cmd("ln", ["-sf", "missing-file", "ignored-broken-link"], cd: parent)

    for target <- targets do
      File.mkdir_p(target)
      System.cmd("touch", ["existing-file"], cd: target)
      System.cmd("ln", ["-sf", "existing-file", "valid-link"], cd: target)
    end

    quiet do
      assert :ok = PreventBrokenSymlinks.run(targets)
    end
  end
end
