defmodule Inter.Pix.Charge.Response.Devedor do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response.Devedor`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct nome: nil,
            cpf: nil
end
