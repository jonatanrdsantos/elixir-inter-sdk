defmodule Inter.Pix.Charge.Response.Valor do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response.Valor`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct original: nil,
            modalidadeAlteracao: nil
end
