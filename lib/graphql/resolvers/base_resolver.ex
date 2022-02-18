defmodule CG.GraphQL.BaseResolver do
  defmacro __using__(_) do
    quote do
      def response({:ok, result}), do: {:ok, result}
      def response({:ok, result}, opts), do: {:ok, message_handler(opts[:success], result)}
      def response({:error, reason}), do: {:error, reason}

      def response({:error, reason}, opts),
        do: {:error, message_handler(opts[:failure], error_handler(reason))}

      defp message_handler(nil, result), do: result
      defp message_handler(message, result), do: %{message: message}

      defp error_handler(%Ecto.Changeset{valid?: false, errors: errors}) do
        Enum.map(errors, fn {key, {message, _}} -> "#{key}_#{message}" end)
      end

      defp error_handler(str) when is_binary(str), do: [str]
    end
  end
end
