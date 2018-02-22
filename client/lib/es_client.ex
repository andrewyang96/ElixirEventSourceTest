defmodule EsClient do
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

    {:ok, _pid} = Supervisor.start_link(children, strategy: :one_for_one)
    receive_loop()
  end

  def receive_loop() do
    receive do
      msg ->
        %{"number" => number} = Poison.Parser.parse!(msg.data)
        IO.puts("Received #{number}")
        receive_loop()
    end
  end
end
