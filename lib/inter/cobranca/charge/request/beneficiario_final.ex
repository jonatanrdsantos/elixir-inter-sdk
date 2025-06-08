defmodule Inter.Cobranca.Charge.Request.BeneficiarioFinal do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request.BeneficiarioFinal`.
  """

  @derive [Nestru.Encoder, Nestru.Decoder]
  defstruct cpfCnpj: nil,
            tipoPessoa: nil,
            nome: nil,
            endereco: nil,
            bairro: nil,
            cidade: nil,
            uf: nil,
            cep: nil
end
