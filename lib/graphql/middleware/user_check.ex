defmodule CG.GraphQL.Middleware.UserCheck do
  @behaviour Absinthe.Middleware
  def call(%Absinthe.Resolution{context: context} = resolution, _config) do
    case context do
      %{session_key: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end
end
