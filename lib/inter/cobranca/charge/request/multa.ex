defmodule Inter.Cobranca.Charge.Request.Multa do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.Multa`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct taxa: nil,
            codigo: nil
end
