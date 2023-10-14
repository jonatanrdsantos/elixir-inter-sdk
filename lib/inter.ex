defmodule Inter do
  @moduledoc """
  Documentation for `Inter`.
  """

  def pix_charge(%Inter.Client{} = client, %Inter.Pix.Charge.Request{} = request) do
    client
      |> Inter.Client.token()
      |> Inter.Client.pix_charge(request)
  end
end
