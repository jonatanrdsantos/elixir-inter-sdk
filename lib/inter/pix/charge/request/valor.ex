defmodule Inter.Pix.Charge.Request.Valor do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Request.Valor`.
  """
  @derive [Nestru.Decoder]
  defstruct original: nil,
            modalidadeAlteracao: nil
end
