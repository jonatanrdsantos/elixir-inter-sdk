defmodule Integration.CobrancaTest do
  use ExUnit.Case, async: false

  @valid_cobranca %Inter.Cobranca.Charge.Request{
    valorNominal: 100.50,
    dataVencimento: "2040-12-20",
    numDiasAgenda: 60,
    contaCorrente: "427144",
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

  setup do
    # Inicializa o GenServer
    client =
      Inter.Client.new(
        client_id: System.get_env("INTER_CLIENT_ID"),
        client_secret: System.get_env("INTER_CLIENT_SECRET"),
        scope: System.get_env("INTER_SCOPE"),
        cert_file: System.get_env("INTER_API_CERT"),
        key_file: System.get_env("INTER_API_KEY"),
        base_url: "https://cdpj-sandbox.partners.uatinter.co/"
      )

    {:ok, _pid} = start_supervised({Inter.TokenManager, client})

    {:ok, client: client}
  end

  describe "charge_cobranca/2" do
    test "creates a cobranca with required parameters" do
      seu_numero = :crypto.strong_rand_bytes(3) |> Base.encode16() |> binary_part(0, 6)
      cobranca = %{@valid_cobranca | seuNumero: seu_numero}

      result = cobranca |> Inter.cobranca_charge()

      assert %Inter.Cobranca.Charge.Response.SimpleResponse{codigoSolicitacao: cod} =
               result.response

      assert cod != nil
    end
  end

  describe "get_cobranca/3" do
    setup do
      seu_numero = :crypto.strong_rand_bytes(3) |> Base.encode16() |> binary_part(0, 6)
      cobranca = %{@valid_cobranca | seuNumero: seu_numero}

      result = cobranca |> Inter.cobranca_charge()

      %Inter.Cobranca.Charge.Response.SimpleResponse{codigoSolicitacao: cod} = result.response

      %{cod: cod, request: cobranca}
    end

    test "retrieves a cobranca", %{cod: cod, request: cobranca} do
      time = DateTime.utc_now() |> Calendar.strftime("%Y-%m-%d")

      # Bind values we want to compare to variables
      data_vencimento = cobranca.dataVencimento
      valor_nominal = cobranca.valorNominal
      pagador_cep = cobranca.pagador.cep
      pagador_cidade = cobranca.pagador.cidade
      pagador_cpf_cnpj = cobranca.pagador.cpfCnpj
      pagador_endereco = cobranca.pagador.endereco
      pagador_nome = cobranca.pagador.nome
      pagador_tipo_pessoa = cobranca.pagador.tipoPessoa
      pagador_uf = cobranca.pagador.uf

      result = cod |> Inter.get_cobranca(cobranca.contaCorrente)

      assert %Inter.Cobranca.Charge.Response{
               boleto: %{
                 "codigoBarras" => _,
                 "linhaDigitavel" => _,
                 "nossoNumero" => _
               },
               cobranca: %{
                 "arquivada" => false,
                 "codigoSolicitacao" => _,
                 "dataEmissao" => ^time,
                 "dataSituacao" => ^time,
                 "dataVencimento" => ^data_vencimento,
                 "descontos" => [],
                 "pagador" => %{
                   "bairro" => "",
                   "cep" => ^pagador_cep,
                   "cidade" => ^pagador_cidade,
                   "complemento" => "",
                   "cpfCnpj" => ^pagador_cpf_cnpj,
                   "email" => "",
                   "endereco" => ^pagador_endereco,
                   "nome" => ^pagador_nome,
                   "numero" => "",
                   "tipoPessoa" => ^pagador_tipo_pessoa,
                   "uf" => ^pagador_uf
                 },
                 "seuNumero" => _,
                 "situacao" => "A_RECEBER",
                 "tipoCobranca" => "SIMPLES",
                 "valorNominal" => ^valor_nominal
               },
               pix: _
             } = result.response
    end
  end
end
