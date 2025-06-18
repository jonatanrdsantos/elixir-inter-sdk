defmodule DecimalEncoderTest do
  use ExUnit.Case, async: true
  alias Decimal

  test "Decimal implements Nestru.Encoder and encodes to float" do
    decimal_value = Decimal.new("123.45")
    encoded = Nestru.encode!(decimal_value)
    assert encoded == "123.45"
  end
end
