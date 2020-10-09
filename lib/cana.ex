defmodule Cana do
  @spec validate_email_address(String.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  @doc ~S"""
  Validate an email address.

  Validate `email_address` according to RFC3696.

  ## Examples
      iex> Cana.validate_email_address("justin@progressiveaspect.com")
      {:ok, %{domain: "progressiveaspect.com", local: "justin"}}

      iex> Cana.validate_email_address("badad\"dress@badplace.com")
      {:error, "expected string \"@\" at column: 5"}
  """
  def validate_email_address(email_address, opts \\ []) when is_binary(email_address) do
    do_validate_email_address(email_address, opts, String.length(email_address))
  end

  defp do_validate_email_address(email_address, opts, length)
       when length >= 6 and length <= 320 do
    email_address
    |> Cana.Validator.validate_email_address(opts)
    |> handle_result()
  end

  defp do_validate_email_address(_email_address, _opts, length),
    do: {:error, "email address length (#{length}) is outside of range 6..320"}

  defp handle_result({:ok, [local, "@" | domain], "", _, _, _}) do
    %{
      local: local,
      domain: domain,
      error: nil
    }
    |> validate_local_length(String.length(local))
    |> validate_domain()
    |> convert_result()
  end

  defp handle_result({:ok, _, extra, _, _, column}) do
    {:error, "Unexpected #{extra} at column: #{column}"}
  end

  defp handle_result({:error, reason, _, _, _, column}) do
    {:error, "#{reason} at column: #{column}"}
  end

  defp validate_local_length(result, length) when length > 64 do
    %{result | error: "local part length(#{length}) is outside the range 1..64"}
  end

  defp validate_local_length(result, _), do: result

  defp validate_domain(%{domain: domain} = result) do
    if Enum.any?(domain, &(String.length(&1) > 63)) do
      %{result | error: "domain label may not exceed 63 characters"}
    else
      domain_part = Enum.join(domain, ".")
      validate_domain_length(%{result | domain: domain_part}, String.length(domain_part))
    end
  end

  defp validate_domain_length(result, length) when length > 255 do
    %{result | error: "domain part length(#{length}) is outside the range 4..255"}
  end

  defp validate_domain_length(result, _), do: result

  defp convert_result(%{error: error}) when not is_nil(error) do
    {:error, error}
  end

  defp convert_result(result) do
    {:ok, Map.drop(result, [:error])}
  end

  @type t :: __MODULE__
end
