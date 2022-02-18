defmodule CG.Repository.Base do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import Ecto.Query, only: [from: 2, where: 2, where: 3, offset: 2]

      @repo Keyword.get(opts, :repo)
      @module_name "#{Module.split(__MODULE__) |> List.last()}" |> String.downcase()

      @doc """
      Возвращает структуру по ее id или по соответствию значения полей структуры
      """
      def get!(opts) when is_list(opts) or is_map(opts) do
        @repo.get_by(__MODULE__, opts_to_map(opts))
      end

      def get!(item_id) do
        @repo.get(__MODULE__, item_id)
      end

      @doc """
      Возвращает структуру по ее id или по соответствию значения полей структуры
      """
      def get(item_id_or_opts) do
        case get!(item_id_or_opts) do
          nil -> {:error, error_not_found()}
          %__MODULE__{} = item -> {:ok, item}
        end
      end

      @doc """
      Возвращает список всех имеющихся структур или по соответствию значения полей структуры
      """
      def get_all!(opts \\ nil) do
        query = @repo.all(from(i in __MODULE__, select: i, order_by: i.id))

        if is_nil(opts) do
          query
        else
          query = filter(query, opts)

          query = if is_nil(opts[:limit]), do: query, else: limit(query, opts[:limit])
          if is_nil(opts[:offset]), do: query, else: offset(query, opts[:offset])
        end
      end

      def get_all(opts \\ nil) do
        case get_all!(opts) do
          [] -> {:error, error_not_found()}
          items -> {:ok, items}
        end
      end

      @doc """
      Создает структуру
      """
      def add(opts) do
        %__MODULE__{}
        |> __MODULE__.changeset(opts_to_map(opts))
        |> @repo.insert()
      end

      def update(%__MODULE__{} = item, opts) do
        __MODULE__.changeset(item, opts_to_map(opts)) |> @repo.update()
      end

      def delete(%__MODULE__{} = item) do
        try do
          @repo.delete(item)
        rescue
          _ -> {:error, error_not_found()}
        end
      end

      defp filter(query, opts), do: filter(query, opts, Enum.count(opts), 0)

      defp filter(query, opts, count, acc) do
        fields = Map.new([Enum.at(opts, acc)]) |> Map.to_list()
        result = query |> where(^fields)

        if acc < count - 1, do: filter(result, opts, count, acc + 1), else: result
      end

      defp opts_to_map(opts) when is_map(opts), do: opts

      defp opts_to_map(opts) when is_list(opts) do
        Enum.reduce(opts, %{}, fn {key, value}, acc -> Map.put(acc, key, value) end)
      end

      defp error_not_found(), do: "#{@module_name}_not_found"
    end
  end
end
