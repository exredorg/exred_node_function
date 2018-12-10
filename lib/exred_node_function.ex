defmodule Exred.Node.Function do
  @moduledoc """
  Executes an arbitrary function to handle incoming messages.

  ### WARNING: This is extremely unsecure. The function is executed as-is in the same beam VM as the rest of the application.
  There are no restricitions imposed on what this function can do.
  """

  @name "Function"
  @category "function"
  @info @moduledoc
  @config %{
    name: %{value: @name, type: "string"},
    code: %{value: "fn(msg, state)->\n\n\t{msg, state}\nend\n", type: "codeblock"}
  }
  @ui_attributes %{right_icon: "build"}

  use Exred.NodePrototype
  require Logger

  @impl true
  def handle_msg(msg, state) do
    {handler, _} = Code.eval_string(state.config.code.value)
    {newmsg, newstate} = handler.(msg, state)
    Logger.debug("SENDING: #{inspect(newmsg)}")
    {newmsg, newstate}
  end
end
