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
