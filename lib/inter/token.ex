defmodule Inter.Token do
  @moduledoc """
  Documentation for `Inter.Token`.
  """
  defstruct access_token: nil,
            token_type: nil,
            expires_in: nil,
            scope: nil
end
