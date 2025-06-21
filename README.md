# Inter SDK

This is a simple wrapper around the Banco Inter's API - a Brazilian digital banking.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `inter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inter, "~> 0.6.0"}
  ]
end
```

You can initialize this client by doing:

```elixir
# The preferable way:
client = Inter.Client.new(client_id: client_id, client_secret: client_secret, scope: scope, api_cert: api_cert, api_key: api_key)

# Or the other way
client = Inter.Client.new(client_id, client_secret, scope, grant_type, api_cert, api_key)
```

You should use the GenServer to keep your token always fresh and avoid rate limiting.

```elixir
# lib/my_app/application.ex

def start(_type, _args) do
  children = [
    # Other supervised gen servers, ex:
    MyApp.Repo,
    MyAppWeb.Endpoint,
    # …
    {Inter.TokenManager, %{
      client: Inter.Client.new(
        client_id: System.get_env("INTER_CLIENT_ID"),
        client_secret: System.get_env("INTER_CLIENT_SECRET"),
        scope: System.get_env("INTER_SCOPE"),
        cert_file: System.get_env("INTER_API_CERT"),
        key_file: System.get_env("INTER_API_KEY")
      )
    }}
  ]

  opts = [strategy: :one_for_one, name: MyApp.Supervisor]
  Supervisor.start_link(children, opts)
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
  infoAdicionais: [
    %Inter.Pix.Charge.Request.InfoAdicional{
      nome: "meu campo adicional", 
      valor: "algum valor 🤩"
    },
    %Inter.Pix.Charge.Request.InfoAdicional{
      nome: "meu campo adicional", 
      valor: "algum valor 🤩"
    },
    %Inter.Pix.Charge.Request.InfoAdicional{
      nome: "meu campo adicional", 
      valor: "algum valor 🤩"
    },
  ],
  chave: "46650032907724"
}

Inter.Client.new(client_id, client_secret, scope, grant_type, api_cert, api_key)
 |> Inter.pix_charge(pix_charge_request)
```

**How to run locally?**

- `docker compose run --rm app bash`
  - `mix deps.get` to install the dependencies
  - `iex -S mix` to open the elixir REPL

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/inter>.
