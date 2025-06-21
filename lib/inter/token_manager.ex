defmodule Inter.TokenFetcher do
  @callback fetch_token(Inter.Client.t()) ::
              {:ok, Inter.Token.t(), integer()} | {:error, term()}
end

defmodule Inter.TokenManager do
  require Logger
  use GenServer

  defmodule State do
    defstruct client: nil,
              expires_at: 0,
              fetcher: Inter.Client
  end

  @refresh_margin 10

  ## Client API
  def start_link(%Inter.Client{} = client) do
    GenServer.start_link(__MODULE__, {client, Inter.Client}, name: __MODULE__)
  end

  def start_link({%Inter.Client{} = client, fetcher}) do
    GenServer.start_link(__MODULE__, {client, fetcher}, name: __MODULE__)
  end

  def get_client do
    GenServer.call(__MODULE__, :get_client)
  end

  ## Server Callbacks
  def init({%Inter.Client{} = client, fetcher}) do
    {:ok, %State{client: client, fetcher: fetcher}}
  end

  def handle_call(:get_client, _from, %State{client: client, expires_at: expires_at, fetcher: fetcher} = state) do
  # def handle_call(:get_client, _from, %State{client: client, expires_at: expires_at} = state) do
    if not_expired?(expires_at) do
      {:reply, client, state}
    else
      case fetch_new_token(client, fetcher) do
        {:ok, new_client, expires_in} ->
          expires_at = System.system_time(:second) + expires_in
          schedule_refresh(expires_in)

          new_state = %State{client: new_client, expires_at: expires_at}
          {:reply, new_client, new_state}

        {:error, reason} ->
          {:reply, {:error, reason}, state}
      end
    end
  end

  def handle_info(:refresh_token, %State{client: client, fetcher: fetcher} = state) do
    case fetch_new_token(client, fetcher) do
      {:ok, new_client, expires_in} ->
        expires_at = System.system_time(:second) + expires_in
        schedule_refresh(expires_in)

        {:noreply, %State{client: new_client, expires_at: expires_at}}

      {:error, _reason} ->
        # Não atualiza, tenta novamente quando solicitado
        {:noreply, state}
    end
  end

  ## Helpers
  defp not_expired?(expires_at), do: System.system_time(:second) < expires_at

  defp schedule_refresh(expires_in) do
    refresh_in = max(expires_in - @refresh_margin, 1) * 1000
    Process.send_after(self(), :refresh_token, refresh_in)
  end

  defp fetch_new_token(client, fetcher) do
    case fetcher.fetch_token(client) do
      %Inter.Token{expires_in: expires_in} = token ->
        new_client = %{client | token: token}
        {:ok, new_client, expires_in}

      {:error, body, response} ->
        Logger.error("[Inter.Client] Failed to fetch token: #{inspect(response)}")
        {:error, "Failed to fetch token #{body}"}
    end
  end
end
