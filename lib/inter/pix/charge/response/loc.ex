defmodule Inter.Pix.Charge.Response.Loc do
  @moduledoc """
  Documentation for `Inter.Pix.Charge.Response.Loc`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct id: nil,
            location: nil,
            tipoCob: nil,
            criacao: nil
end
