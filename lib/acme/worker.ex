defmodule Acme.Worker do
  alias __MODULE__, as: This

  use GenServer

  @ets_table_name :worker_table

  #===========================================================================
  # Public API
  #===========================================================================

  def start_link(opts) do
    GenServer.start_link(This, opts, [])
  end


  def do_the_work(pid) do
    GenServer.cast(pid, :do_the_work)
  end

  #===========================================================================
  # Callback implementations
  #===========================================================================

  def init(opts) do
    interval = Keyword.get(opts, :interval, 500)
    worker_proc = self()

    # create an ets table we can query from
    :ets.new(@ets_table_name, [:set, :protected, :named_table])
    :ets.insert(@ets_table_name, {:some_key, :some_value})
    :ets.insert(@ets_table_name, {:other_key, :other_value})

    spawn_link(fn -> trigger_the_worker(worker_proc, interval) end)
    {:ok, :some_state}
  end


  def handle_cast(:do_the_work, state) do
    # exercises 1&2
    _all_tables = :ets.all()
    _some_tuple = :ets.lookup(@ets_table_name, :some_key)
    _some_tuple = :ets.lookup(@ets_table_name, :not_here)

    {:noreply, state}
  end

  #===========================================================================
  # Internal functions
  #===========================================================================

  defp trigger_the_worker(pid, interval) do
    receive do
    after
      interval ->
        do_the_work(pid)
        trigger_the_worker(pid, interval)
    end
  end

end
