defmodule Inter.Pix.Charge.Response do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response`.
  """
  @derive {Nestru.Decoder,
           hint: %{
             loc: Inter.Pix.Charge.Response.Loc,
             valor: Inter.Pix.Charge.Response.Valor,
             calendario: Inter.Pix.Charge.Response.Calendario,
             devedor: Inter.Pix.Charge.Response.Devedor
           }}
  defstruct chave: nil,
            info_adicionais: [],
            pix_copia_e_cola: nil,
            loc: %Inter.Pix.Charge.Response.Loc{},
            location: nil,
            status: nil,
            valor: %Inter.Pix.Charge.Response.Valor{},
            calendario: %Inter.Pix.Charge.Response.Calendario{},
            txid: nil,
            revisao: nil,
            devedor: %Inter.Pix.Charge.Response.Devedor{}
end
