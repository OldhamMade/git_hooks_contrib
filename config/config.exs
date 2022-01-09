import Config

config :git_hooks,
  auto_install: true,
  verbose: true,
  hooks: [
    pre_commit: [
      tasks: [
        {:mix_task, :compile, ["--warnings-as-errors"]},
        {:mix_task, :format, ["--check-formatted"]}
      ]
    ]
  ]
