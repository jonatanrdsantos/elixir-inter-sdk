defmodule QRCode.Generator do
  def generate(data, :svg) do
    data
    |> EQRCode.encode()
    |> EQRCode.svg()
  end

  def generate(data, :png) do
    data
    |> EQRCode.encode()
    |> EQRCode.png()
  end
end
