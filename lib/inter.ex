defmodule Inter do
  alias QRCode.Generator

  require Inter.Protocols

  @moduledoc """
  Documentation for `Inter`.
  """

  def pix_charge(%Inter.Pix.Charge.Request{} = request) do
    Inter.TokenManager.get_client()
    |> Inter.Client.pix_charge(request)
  end

  def get_pix(txid) do
    case txid do
      _ -> Inter.TokenManager.get_client() |> Inter.Client.get_pix(txid)
    end
  end

  def cobranca_charge(%Inter.Cobranca.Charge.Request{} = request) do
    Inter.TokenManager.get_client()
    |> Inter.Client.cobranca_charge(request)
  end

  def get_cobranca(cod, conta_corrente) do
    case cod do
      _ -> Inter.TokenManager.get_client() |> Inter.Client.get_cobranca(cod, conta_corrente)
    end
  end

  def cobranca_charge(%Inter.Webhook.Request{} = request, type \\ :boleto) do
    Inter.TokenManager.get_client()
    |> Inter.Client.create_webhook(request, type)
  end

  def get_webhook(%Inter.Webhook.Request{} = request, type \\ :boleto) do
    Inter.TokenManager.get_client()
    |> Inter.Client.get_webhook(request, type)
  end

  def pix_qr_code(%Inter.Client{} = client) do
    case client.response do
      %Inter.Pix.Charge.Response{} = response ->
        %Inter.Pix.Charge.Response{
          client.response
          | qrCode: Generator.generate(response.pixCopiaECola, :svg)
        }

      nil ->
        nil
    end
  end
end
