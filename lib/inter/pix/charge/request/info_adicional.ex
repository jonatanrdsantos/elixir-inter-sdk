defmodule Inter.Pix.Charge.Request.InfoAdicional do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Request.InfoAdicional`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct nome: nil,
            valor: nil
end
