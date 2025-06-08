defmodule CobrancaTest do
  use ExUnit.Case

  describe "charge_cobranca/2" do
    test "creates a cobranca with required parameters" do
      client = Inter.Client.new(
        System.get_env("INTER_CLIENT_ID"),
        System.get_env("INTER_CLIENT_SECRET"),
        System.get_env("INTER_SCOPE"),
        "client_credentials",
        System.get_env("INTER_API_CERT"),
        System.get_env("INTER_API_KEY"),
        "https://cdpj-sandbox.partners.uatinter.co/"
      )

      seu_numero = :crypto.strong_rand_bytes(3) |> Base.encode16() |> binary_part(0, 6)

      request = %Inter.Cobranca.Charge.Request{
        seuNumero: seu_numero,
        valorNominal: 100.50,
        dataVencimento: "2040-12-20",
        numDiasAgenda: 60,
        pagador: %Inter.Cobranca.Charge.Request.Pagador{
          cpfCnpj: "51503623000118",
          tipoPessoa: "JURIDICA",
          nome: "Test User",
          endereco: "Rua Teste, 123",
          cidade: "São Paulo",
          uf: "SP",
          cep: "01234567"
        }
      }

      result = client |> Inter.cobranca_charge(request)

      assert %Inter.Cobranca.Charge.Response{codigoSolicitacao: cod} = result.response
      assert cod != nil
    end
  end
end
