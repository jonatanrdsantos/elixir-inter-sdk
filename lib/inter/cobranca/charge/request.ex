defmodule Inter.Cobranca.Charge.Request do
  @moduledoc """
  Documentation for `Inter.Cobranca.Charge.Request`.
  """

  @derive [
    {Nestru.Encoder,
     hint: %{
       pagador: Inter.Cobranca.Charge.Request.Pagador,
       desconto: Inter.Cobranca.Charge.Request.Desconto,
       multa: Inter.Cobranca.Charge.Request.Multa,
       mora: Inter.Cobranca.Charge.Request.Mora,
       mensagem: Inter.Cobranca.Charge.Request.Mensagem,
       beneficiarioFinal: Inter.Cobranca.Charge.Request.BeneficiarioFinal
     }},
    {Nestru.Decoder,
     hint: %{
       pagador: Inter.Cobranca.Charge.Request.Pagador,
       desconto: Inter.Cobranca.Charge.Request.Desconto,
       multa: Inter.Cobranca.Charge.Request.Multa,
       mora: Inter.Cobranca.Charge.Request.Mora,
       mensagem: Inter.Cobranca.Charge.Request.Mensagem,
       beneficiarioFinal: Inter.Cobranca.Charge.Request.BeneficiarioFinal
     }}
  ]
  defstruct contaCorrente: nil,
            seuNumero: nil,
            valorNominal: nil,
            dataVencimento: nil,
            numDiasAgenda: nil,
            pagador: nil,
            desconto: nil,
            multa: nil,
            mora: nil,
            mensagem: nil,
            beneficiarioFinal: nil
end
