defmodule Inter do
  alias QRCode.Generator

  @moduledoc """
  Documentation for `Inter`.
  """

  def pix_charge(%Inter.Client{} = client, %Inter.Pix.Charge.Request{} = request) do
    client
    |> Inter.Client.token()
    |> Inter.Client.pix_charge(request)
  end

  def get_pix(%Inter.Client{} = client, txid) do
    case txid do
      _ -> client |> Inter.Client.token() |> Inter.Client.get_pix(txid)
    end
  end

  def cobranca_charge(%Inter.Client{} = client, %Inter.Cobranca.Charge.Request{} = request) do
    client
    |> Inter.Client.token()
    |> Inter.Client.cobranca_charge(request)
  end

  def get_cobranca(%Inter.Client{} = client, cod, conta_corrente) do
    case cod do
      _ -> client |> Inter.Client.token() |> Inter.Client.get_cobranca(cod, conta_corrente)
    end
  end

  def cobranca_charge(%Inter.Client{} = client, %Inter.Webhook.Request{} = request, type \\ :boleto) do
    client
    |> Inter.Client.token()
    |> Inter.Client.create_webhook(request, type)
  end

  def get_webhook(%Inter.Client{} = client, %Inter.Webhook.Request{} = request, type \\ :boleto) do
    client |> Inter.Client.token() |> Inter.Client.get_webhook(request, type)
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
end
