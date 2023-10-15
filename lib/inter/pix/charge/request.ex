defmodule Inter.Pix.Charge.Request do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Request`.
  """

  @derive
  @derive [{Nestru.Encoder,
    hint: %{
      calendario: Inter.Pix.Charge.Request.Calendario,
      devedor: Inter.Pix.Charge.Request.Devedor,
      valor: Inter.Pix.Charge.Request.Valor,
      infoAdicionais: [Inter.Pix.Charge.Request.InfoAdicional]
    }}, {Nestru.Decoder,
    hint: %{
      calendario: Inter.Pix.Charge.Request.Calendario,
      devedor: Inter.Pix.Charge.Request.Devedor,
      valor: Inter.Pix.Charge.Request.Valor,
      infoAdicionais: [Inter.Pix.Charge.Request.InfoAdicional]
    }}]
  defstruct calendario: nil,
            devedor: nil,
            valor: nil,
            chave: nil,
            infoAdicionais: []
end
