defmodule Inter.TokenManager do
  use GenServer
  require Logger

  @token_refresh_threshold 300 # 5 minutes in seconds

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_token(client) do
    GenServer.call(__MODULE__, {:get_token, client})
  end

  @impl true
  def init(_) do
    {:ok, %{token: nil, expires_at: nil, client: nil}}
  end

  @impl true
  def handle_call({:get_token, client}, _from, state) do
    now = DateTime.utc_now() |> DateTime.to_unix()

    {token, new_state} =
      cond do
        # No token or client changed
        is_nil(state.token) or state.client != client ->
          fetch_new_token(client)

        # Token expired or about to expire
        state.expires_at <= now + @token_refresh_threshold ->
          fetch_new_token(client)

        # Token is still valid
        true ->
          {state.token, state}
      end

    {:reply, token, new_state}
  end

  defp fetch_new_token(client) do
    case Inter.Client.token(client) do
      %Inter.Client{token: token} = updated_client ->
        expires_at = DateTime.utc_now() |> DateTime.add(token.expires_in, :second) |> DateTime.to_unix()
        new_state = %{token: token, expires_at: expires_at, client: client}
        {token, new_state}

      {:error, reason, _} ->
        Logger.error("Failed to fetch token: #{inspect(reason)}")
        {:error, "Failed to fetch token"}
    end
  end
end
