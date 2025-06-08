defmodule Inter.Cobranca.Charge.Request.Mensagem do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.Mensagem`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct linha1: nil,
            linha2: nil,
            linha3: nil,
            linha4: nil,
            linha5: nil
end
