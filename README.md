# Inter

This is a simple wrapper around the Banco Inter's API - a Brazilian digital banking.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `inter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inter, "~> 0.1.1"}
  ]
end
```


Usage:
```elixir
api_key = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDQ8Z4ZQ8Z4ZQ8Z\n-----END PRIVATE KEY-----\n"
api_cert = "-----BEGIN CERTIFICATE-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDQ8Z4ZQ8Z4ZQ8Z\n-----END CERTIFICATE-----\n"
grant_type = "client_credentials"
scope = "pix.write pix.read webhook.read webhook.write cob.write pagamento-pix.write"
client_secret = "secret"
client_id = "client_id"

pix_charge_request = %Inter.Pix.Charge.Request{
  calendario: %Inter.Pix.Charge.Request.Calendario{
    expiracao: 3600
  },
  devedor: %Inter.Pix.Charge.Request.Devedor{
    cpf: "40894943030",
    nome: "Jhon Doe"
  },
  valor: %Inter.Pix.Charge.Request.Valor{
    original: "5.00", 
    modalidadeAlteracao: 1
  },
  chave: "46650032907724"
}

Inter.Client.new(client_id, client_secret, scope, grant_type, api_cert, api_key)
 |> Inter.pix_charge(pix_charge_request)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/inter>.
