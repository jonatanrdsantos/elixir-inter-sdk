defmodule PixTest do
  use ExUnit.Case

  describe "get_pix/2" do
    @tag :skip
    test "receive the Inter.Pix.Charge.Response when the pix was found" do
      # Setup test client
      client = Inter.Client.new(
        System.get_env("INTER_CLIENT_ID"),
        System.get_env("INTER_CLIENT_SECRET"),
        "pix.read",
        "client_credentials",
        System.get_env("INTER_API_CERT"),
        System.get_env("INTER_API_KEY"),
        "https://cdpj-sandbox.partners.uatinter.co/"
      )

      # Mock successful response
      expected_response = %Inter.Pix.Charge.Response{
        txid: "test_txid",
        status: "ATIVA",
        valor: %Inter.Pix.Charge.Response.Valor{original: "10.00"},
        calendario: %Inter.Pix.Charge.Response.Calendario{expiracao: 3600},
        devedor: %Inter.Pix.Charge.Response.Devedor{
          nome: "Test User",
          cpf: "12345678900"
        }
      }

      # Mock HTTPoison.get to return success
      # expect(HTTPoison, :get, fn _url, _headers, _options ->
      #   {:ok, %HTTPoison.Response{
      #     status_code: 200,
      #     body: Jason.encode!(expected_response)
      #   }}
      # end)

      # Execute the function
      result = Inter.get_pix(client, "test_txid")

      # Assert the response
      assert result.response == expected_response
    end

    @tag :skip
    test "receives a 404 when pix is not found" do
      client = Inter.Client.new(
        System.get_env("INTER_CLIENT_ID"),
        System.get_env("INTER_CLIENT_SECRET"),
        "pix.read",
        "client_credentials",
        System.get_env("INTER_API_CERT"),
        System.get_env("INTER_API_KEY"),
        "https://cdpj-sandbox.partners.uatinter.co/"
      )

      result = Inter.get_pix(client, "invalid_txid")

      assert result.response == %{}

    end
  end
end
