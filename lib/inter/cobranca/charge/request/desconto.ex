defmodule Inter.Cobranca.Charge.Request.Desconto do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.Desconto`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct taxa: nil,
            codigo: nil,
            quantidadeDias: nil
end
