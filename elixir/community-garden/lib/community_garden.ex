# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    # Please implement the start/1 function
    Agent.start(fn -> [] end, opts)
  end

  def list_registrations(pid) do
    # Please implement the list_registrations/1 function
    Agent.get(pid, fn state -> state end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot_id =
        case state do
          [] -> 1
          _ -> Enum.max_by(state, & &1.plot_id).plot_id + 1
        end
      plot = %Plot{plot_id: plot_id, registered_to: register_to}
      new_state = [plot | state]
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
    # partial
    # partial
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
  end
end
