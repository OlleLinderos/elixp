ExUnit.start()

defmodule ExpectFailure do
  defmacro expect_failure(ast) do
    quote do
      try do
        unquote(ast)
        flunk("This should has crashed: " <> unquote(Macro.to_string(ast)))
      rescue
        e in ExUnit.AssertionError ->
          raise e

        _ ->
          :ok
      end
    end
  end
end
