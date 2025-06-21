defmodule Inter.TokenManagerTest do
  use ExUnit.Case, async: false
  alias Inter.TokenManager
  alias Inter.Client

  import Mox

  setup :set_mox_global

  setup do
    # Client "fake" para testar
    client = %Client{
      token: "initial_token",
      client_id: "fake_id",
      client_secret: "fake_secret",
      scope: "fake_scope",
      cert_file: "fake_cert",
      key_file: "fake_key",
      base_url: "https://cdpj.partners.bancointer.com.br/",
      request_options: []
    }

    {:ok, pid} = start_supervised({TokenManager, {client, Inter.ClientMock}})

    %{pid: pid, client: client}
  end

  test "get_client returns the current client when not expired", %{client: client} do
    Inter.ClientMock
    |> Mox.expect(:fetch_token, fn ^client ->
      %Inter.Token{access_token: "new_token", expires_in: 3600}
    end)

    client = TokenManager.get_client()

    assert client.token == %Inter.Token{
             access_token: "new_token",
             token_type: nil,
             expires_in: 3600,
             scope: nil
           }
  end

  test "refreshes the token when expired", %{client: client} do
    Inter.ClientMock
    |> Mox.expect(:fetch_token, fn ^client ->
      %Inter.Token{access_token: "new_token", expires_in: 3600}
    end)

    # Simula expiração
    :sys.replace_state(TokenManager, fn state ->
      %{state | expires_at: System.system_time(:second) - 1}
    end)

    # Mock para verificar se o fetch_new_token foi chamado corretamente
    # Nesse caso, você poderia usar o Mox para mockar Inter.Client.fetch_token/1
    # mas aqui vamos verificar só se não retorna error e atualiza o client
    result = TokenManager.get_client()
    assert match?(%Client{}, result), "Deve retornar um Client atualizado"
    refute result.token == "initial_token"
  end

  test "doesn't refresh when not expired", %{client: client} do
    Inter.ClientMock
    |> Mox.expect(:fetch_token, fn ^client ->
      %Inter.Token{access_token: "new_token", expires_in: 3600}
    end)

    old_client = TokenManager.get_client()
    new_client = TokenManager.get_client()
    assert old_client.token == new_client.token
  end
end
