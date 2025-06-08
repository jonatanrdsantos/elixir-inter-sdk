defmodule Inter.Cobranca.Charge.Request.Mora do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.Mora`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct taxa: nil,
            codigo: nil
end
