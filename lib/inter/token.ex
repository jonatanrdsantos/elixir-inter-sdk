defmodule Inter.Token do
  @moduledoc """
  Documentation for `Inter.Token`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct access_token: nil,
            token_type: nil,
            expires_in: nil,
            scope: nil
end
