defmodule Inter.Webhook.Response do
  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct webhookUrl: nil, criacao: nil, atualizacao: nil
end
