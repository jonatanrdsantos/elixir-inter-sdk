defmodule Inter do
  alias QRCode.Generator
  require Logger

  @moduledoc """
  Documentation for `Inter`.
  """

  def start_link do
    Inter.TokenManager.start_link([])
  end

  def pix_charge(%Inter.Client{} = client, %Inter.Pix.Charge.Request{} = request) do
    with {:ok, token} <- get_token(client) do
      client
      |> Map.put(:token, token)
      |> Inter.Client.pix_charge(request)
    end
  end

  def get_pix(%Inter.Client{} = client, txid) do
    with {:ok, token} <- get_token(client) do
      client
      |> Map.put(:token, token)
      |> Inter.Client.get_pix(txid)
    end
  end

  def cobranca_charge(%Inter.Client{} = client, %Inter.Cobranca.Charge.Request{} = request) do
    with {:ok, token} <- get_token(client) do
      client
      |> Map.put(:token, token)
      |> Inter.Client.cobranca_charge(request)
    end
  end

  def get_cobranca(%Inter.Client{} = client, cod, conta_corrente) do
    with {:ok, token} <- get_token(client) do
      client
      |> Map.put(:token, token)
      |> Inter.Client.get_cobranca(cod, conta_corrente)
    end
  end

  def pix_qr_code(%Inter.Client{} = client) do
    case client.response do
      %Inter.Pix.Charge.Response{} = response ->
        %Inter.Client{
          client
          | response: %Inter.Pix.Charge.Response{
              client.response
              | qrCode: Generator.generate(response.pixCopiaECola, :svg)
            }
        }

      nil ->
        nil
    end
  end

  defp get_token(client) do
    case Inter.TokenManager.get_token(client) do
      {:error, reason} -> {:error, reason}
      token -> {:ok, token}
    end
  end
end
