defmodule EsClient.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(EsClient.SSE, ["http://localhost:3000/"])
    ]

    opts = [strategy: :one_for_one, name: EsClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule EsClient.SSE do
  use Supervisor

  def start_link(url) do
    Supervisor.start_link(__MODULE__, url, [])
  end

  def init(url) do
    children = [
      %{
        id: EventsourceEx,
        start: {EventsourceEx, :new, [url, [{:stream_to, self()}]]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def handle_info(msg) do
    IO.inspect(msg)
    {:noreply, %{}}
  end
end
