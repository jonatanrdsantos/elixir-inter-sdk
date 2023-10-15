defmodule Inter.Pix.Charge.Response.Calendario do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response.Calendario`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct expiracao: nil,
            criacao: nil
end
