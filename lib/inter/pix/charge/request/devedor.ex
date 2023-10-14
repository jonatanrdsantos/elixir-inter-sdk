defmodule Inter.Pix.Charge.Request.Devedor do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Request.Devedor`.
  """
  @derive [Nestru.Decoder]
  defstruct cpf: nil,
            nome: nil
end
