defmodule Helper.BaseService do
  defmacro __using__(_opts) do
    quote do
      def required_param(param, keys \\ "parameter is empty", message \\ "parameter is empty")
      # def required_param(param, key_name, message \\ "parameter is empty")

      @doc """
      Check values on nil

      ACCCEPT required_param(id: "var")
      ## Examples
        iex > required_param(%{map: nil, map2: nil})

        {:error, %{map: "is_not_nil",map2: "is_no_nil"}}

        iex > required_param(%{map: "!@3", map2: "!@#"})

        :ok
      """
      def required_param(param, keys, message) when is_map(param) and is_list(keys) do
        Enum.map(keys, fn key ->
          if is_nil(param[key]), do: throw({:error, "#{key} #{message}"})
        end)

        :ok
      end

      @doc """
         Check value on nil

         ACCCEPT required_param(value, message)
         ## Examples

        iex > required_param(nil, "nil")

        {:error, "nil"}

        iex > required_param(nil, "nil")

        :ok
      """
      def required_param(param, message, _message) do
        if is_nil(param), do: throw({:error, "#{message}"})

        :ok
      end
    end
  end
end
