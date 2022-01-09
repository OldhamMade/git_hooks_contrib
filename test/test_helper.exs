ExUnit.start()

defmodule ExUnit.Quiet do
  import ExUnit.CaptureIO

  defmacro quiet(body) do
    quote do
      capture_io(fn ->
        unquote(body)
      end)
    end
  end
end
