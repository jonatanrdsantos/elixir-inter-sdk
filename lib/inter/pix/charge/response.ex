defmodule Inter.Pix.Charge.Response do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response`.
  """
  @derive [
    {Nestru.Encoder,
     hint: %{
       loc: Inter.Pix.Charge.Response.Loc,
       valor: Inter.Pix.Charge.Response.Valor,
       calendario: Inter.Pix.Charge.Response.Calendario,
       devedor: Inter.Pix.Charge.Response.Devedor
     }},
    {Nestru.Decoder,
     hint: %{
       loc: Inter.Pix.Charge.Response.Loc,
       valor: Inter.Pix.Charge.Response.Valor,
       calendario: Inter.Pix.Charge.Response.Calendario,
       devedor: Inter.Pix.Charge.Response.Devedor
     }}
  ]
  defstruct chave: nil,
            infoAdicionais: [],
            pixCopiaECola: nil,
            loc: %Inter.Pix.Charge.Response.Loc{},
            location: nil,
            status: nil,
            valor: %Inter.Pix.Charge.Response.Valor{},
            calendario: %Inter.Pix.Charge.Response.Calendario{},
            txid: nil,
            revisao: nil,
            devedor: %Inter.Pix.Charge.Response.Devedor{},
            qrCode: nil
end
