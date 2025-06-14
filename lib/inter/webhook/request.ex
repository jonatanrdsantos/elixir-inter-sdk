defmodule Inter.Webhook.Request do
  @moduledoc """
  Documentation for `Inter.Webhook.Request`.
  """
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct webhookUrl: nil, contaCorrente: nil, chavePix: nil
end
