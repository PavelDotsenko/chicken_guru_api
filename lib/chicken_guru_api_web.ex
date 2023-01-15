defmodule CGWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use CGWeb, :controller
      use CGWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: CGWeb

      import Plug.Conn
      import CGWeb.PrepareForRest

      alias CGWeb.Router.Helpers, as: Routes

      @iso_time_offset Application.get_env(:chicken_guru_api, :iso_time_offset)

      defmacro check_throw(function) do
        quote do
          try do
            unquote(function)
          catch
            any -> any
          end
        end
      end

      def response(func, conn) when is_function(func) do
        try do
          func
        catch
          any -> any
        end
      end

      def response({:ok, data}, conn) do
        conn
        |> json(
          prepare(%{
            timestamptz:
              DateTime.utc_now() |> DateTime.to_iso8601(:extended, 3600 * @iso_time_offset),
            message: "",
            errors: [],
            data: data
          })
        )
      end

      def response({:error, "unauthorized"}, conn) do
        conn
        |> error_response("unauthorized", 401)
      end

      def response({:error, %Ecto.Changeset{errors: errors}}, conn) do
        errors_map =
          errors
          |> Enum.reduce(%{}, fn {key, {message, _}}, acc ->
            Map.merge(acc, %{key => message})
          end)

        conn
        |> error_response(errors_map)
      end

      def response({:error, errors}, conn) when is_map(errors) do
        conn
        |> error_response(errors)
      end

      def response({:error, errors}, conn) when is_binary(errors) do
        conn
        |> error_response(errors)
      end

      def response({:error, errors}, conn) do
        conn
        |> error_response(errors)
      end

      defp error_response(conn, errors, code \\ 400) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          code,
          Jason.encode!(
            prepare(%{
              timestamptz:
                DateTime.utc_now() |> DateTime.to_iso8601(:extended, 3600 * @iso_time_offset),
              message: if(is_bitstring(errors), do: errors, else: ""),
              errors: if(is_map(errors) or is_list(errors), do: errors, else: []),
              data: %{}
            })
          )
        )
      end

      defp struct_to_map(data) when is_list(data) do
        Enum.map(data, &struct_to_map/1)
      end

      defp struct_to_map(data) when is_struct(data) do
        data
        |> Map.from_struct()
        |> Map.drop([:__meta__])
        |> normalize_map()
      end

      defp normalize_map(data) when is_map(data) do
        Map.new(data, fn {key, val} ->
          value =
            cond do
              is_map(val) and not is_struct(val) ->
                normalize_map(val)

              is_list(val) ->
                if val != [], do: normalize_map(val), else: val

              true ->
                val
            end

          {
            if(is_atom(key), do: key, else: String.to_atom(key)),
            value
          }
        end)
      end

      defp struct_to_map(data), do: data
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/chicken_guru_api_web/templates",
        namespace: CGWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import CGWeb.ErrorHelpers
      alias CGWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
