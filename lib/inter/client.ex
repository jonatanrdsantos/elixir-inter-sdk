defmodule Inter.Client do
  @moduledoc """
  Documentation for `Inter.Client`.
  """

  defstruct base_url: "https://cdpj.partners.bancointer.com.br/",
            client_id: nil,
            client_secret: nil,
            scope: nil,
            grant_type: nil,
            cert_file: nil,
            key_file: nil,
            token: nil,
            request: nil,
            request_options: nil,
            response: nil

  @doc """
  Build new client.

  ## Examples

      iex> Inter.Client.new("some_client_id", "some_client_secret", "scope", "grant_type", "cert_file", "key_file")
      %Inter.Client{
         base_url: "https://cdpj.partners.bancointer.com.br/",
         client_id: "some_client_id",
         client_secret: "some_client_secret",
         scope: "scope",
         grant_type: "grant_type",
         cert_file: "cert_file",
         key_file: "key_file"
       }
  """
  def new(client_id, client_secret, scope, grant_type, cert_file, key_file) do
    {type, encoded, _atom} = key_file |> :public_key.pem_decode() |> hd()

    %__MODULE__{
      client_id: client_id,
      client_secret: client_secret,
      scope: scope,
      grant_type: grant_type,
      cert_file: cert_file,
      key_file: key_file,
      request_options: [
        recv_timeout: 30_000,
        ssl: [
          versions: [:"tlsv1.2"],
          cert: cert_file |> :public_key.pem_decode() |> hd() |> elem(1),
          key: {type, encoded}
        ]
      ]
    }
  end

  def token(%__MODULE__{} = client) do
    data = [
      {"client_id", client.client_id},
      {"client_secret", client.client_secret},
      {"scope", client.scope},
      {"grant_type", client.grant_type}
    ]

    headers = [{"Content-Type", "application/x-www-form-urlencoded"}]

    response =
      HTTPoison.post(
        client.base_url <> "oauth/v2/token",
        {:form, data},
        headers,
        client.request_options
      )

    %__MODULE__{
      client
      | token: handle_response(response, %Inter.Token{})
    }
  end

  def pix_charge(%__MODULE__{} = client, %Inter.Pix.Charge.Request{} = request) do
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer " <> client.token.access_token}
    ]

    response =
      HTTPoison.post(
        client.base_url <> "pix/v2/cob",
        Poison.encode!(request),
        headers,
        client.request_options
      )

    %__MODULE__{
      client
      | request: request,
        response: handle_response(response, %Inter.Pix.Charge.Response{})
    }
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, type),
    do: body |> Poison.decode!(as: type)

  defp handle_response({:ok, %HTTPoison.Response{status_code: 201, body: body}}, type),
    do: body |> Poison.decode!(as: type)

  defp handle_response(response, _type), do: {:error, "Failed to obtain OAuth token", response}

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}),
    do: body |> Poison.decode!()

  defp handle_response({:ok, %HTTPoison.Response{status_code: 201, body: body}}),
    do: body |> Poison.decode!()

  defp handle_response(response), do: {:error, "Failed to obtain OAuth token", response}
end
