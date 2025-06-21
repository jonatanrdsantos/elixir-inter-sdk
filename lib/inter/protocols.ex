defmodule Inter.Protocols do
end

alias Decimal
require Decimal

defimpl Nestru.Encoder, for: Decimal do
  def gather_fields_from_struct(decimal, _hint) do
    {:ok, Decimal.to_string(decimal)}
  end
end
