defmodule Inter.Cobranca.Charge.Request.Pagador do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.Pagador`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct email: nil,
            ddd: nil,
            telefone: nil,
            numero: nil,
            complemento: nil,
            cpfCnpj: nil,
            tipoPessoa: nil,
            nome: nil,
            endereco: nil,
            bairro: nil,
            cidade: nil,
            uf: nil,
            cep: nil
end
