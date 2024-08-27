# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    # Please implement the start/1 function
    initial_state = %{plots: [], next_id: 1}
    Agent.start(fn -> initial_state end, opts)
  end

  def list_registrations(pid) do
    # Please implement the list_registrations/1 function
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot_id = state.next_id
      plot = %Plot{plot_id: plot_id, registered_to: register_to}
      new_state = %{state | plots: [plot | state.plots], next_id: plot_id + 1}
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
    case list_registrations(pid) do
      [] ->
        {:error, "No registrations found"}

      registrations ->
        case Enum.find(registrations, fn plot -> plot.plot_id == plot_id end) do
          nil ->
            {:error, "Plot not found"}

          plot ->
            Agent.update(pid, fn state ->
              new_plots = Enum.reject(state.plots, fn p -> p.plot_id == plot_id end)
              %{state | plots: new_plots}
            end)

            :ok
        end
    end
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
    case list_registrations(pid) do
      [] ->
        {:not_found, "plot is unregistered"}

      registrations ->
        case Enum.find(registrations, fn plot -> plot.plot_id == plot_id end) do
          nil -> {:not_found, "plot is unregistered"}
          plot -> plot
        end
    end
  end
end
