# GitHooksContrib
<!-- start:overview -->
<!-- start:description -->
`git_hooks_contrib` is a set of useful checks that can be executed by
the `git_hooks` package.
<!-- end:description -->

## Motivation

Git hooks are a great way to introduce useful actions into a project's
development workflow, to help automate common commands and steps
needed to maintain good codebase hygeine and capture potential issues
that may not be captured by normal testing/analysis tools.

However, git hooks aren't normally stored & shared along with project
files as part of version control within git, so they need to be
managed and tracked outside of the project in which they're used.

Projects like [`pre-commit`](https://pre-commit.com) help to provide some
reusability for useful/common git hooks, and has many useful
contributions itself, but it as yet does not provide a way to store
and manage hooks with a project's files.

The [`git_hooks`](https://hex.pm/packages/git_hooks) package helps
to resolve this for the Elixir world, by managing hooks as part of the
standard `mix` workflows.

This contrib module aims to provide a set of useful checks (inspired
by the `pre-commit` contributions) which can be easily included as
part of a project, without introducing any new dependencies, and
enabled as needed by the projects `git_hooks` config.

Note that we avoid duplicating checks that should be/are already done
by tools such as [`credo`](https://hex.pm/packages/credo),
[`sobelow`](https://hex.pm/packages/sobelow), and mix itself, which
are often already part of the workflow for many projects.

## Installation

The package can be installed by adding `git_hooks_contrib` to your
list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:git_hooks_contrib, "~> 0.1.0", only: [:dev], runtime: false}
  ]
end
```

## Usage

```elixir
config :git_hooks,
  hooks: [
    pre_commit: [
      {:mix_task, :"git_hooks.run_contrib", ["contrib-script-name"]}
    ]
  ]
```

## Available Hooks

- prevent-broken-symlinks

<!-- end:overview -->
## Contributing

**Note: the project is made & maintained by a small team of humans,
who on occasion may make mistakes and omissions.**

The project is managed on a best-effort basis, and aims to be "good
enough". If there are issues or missing features please raise a ticket
or create a Pull Request by following these steps:

1.  [Fork it][fork]
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Raise a new pull request via GitHub

Please be sure to review the [development guide][devguide] before
finalising your contribution for review.

## Liability

We take no responsibility for the use of our tool, or external
instances provided by third parties. We strongly recommend you abide
by the valid official regulations in your country. Furthermore, we
refuse liability for any inappropriate or malicious use of this
tool. This tool is provided to you in the spirit of free, open
software.

You may view the LICENSE in which this software is provided to you
[here](./LICENSE).

> 8. Limitation of Liability. In no event and under no legal theory,
>    whether in tort (including negligence), contract, or otherwise,
>    unless required by applicable law (such as deliberate and grossly
>    negligent acts) or agreed to in writing, shall any Contributor be
>    liable to You for damages, including any direct, indirect, special,
>    incidental, or consequential damages of any character arising as a
>    result of this License or out of the use or inability to use the
>    Work (including but not limited to damages for loss of goodwill,
>    work stoppage, computer failure or malfunction, or any and all
>    other commercial damages or losses), even if such Contributor
>    has been advised of the possibility of such damages.


[fork]: https://github.com/OldhamMade/git_hooks_contrib/fork
[devguide]: ./DEVELOPMENT.md
