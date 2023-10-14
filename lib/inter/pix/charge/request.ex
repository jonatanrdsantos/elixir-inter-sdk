defmodule Inter.Pix.Charge.Request do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Request`.
  """

  @derive {Nestru.Decoder,
           hint: %{
             calendario: Inter.Pix.Charge.Request.Calendario,
             devedor: Inter.Pix.Charge.Request.Devedor,
             valor: Inter.Pix.Charge.Request.Valor
           }}
  @derive Nestru.Encoder
  defstruct calendario: nil,
            devedor: nil,
            valor: nil,
            chave: nil
end
