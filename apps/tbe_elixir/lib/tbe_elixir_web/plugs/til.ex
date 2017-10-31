  defmodule TbeElixirWeb.Plug.Til do
    import Plug.Conn

    @doc false
    def init(default), do: default

    @doc """
    This plug ensures that the subdomain of "www" gets routed to the standard page_controller, subdomains of "til" get routed to the til page_controller, no subdomain also goes to the standard page_controller, and everything else goes to a 404.
    """
    def call(conn, _router) do
      subdomain = get_subdomain(conn.host)

      case subdomain do
        subdomain when byte_size(subdomain) == 0 -> conn
        subdomain when subdomain == "www" -> conn
        subdomain when subdomain == "til" ->
          conn
          |> TilexWeb.Endpoint([])
          |> halt
        _ -> conn
      end
    end

  defp get_subdomain(host) do
    host
    |> String.split(".")
    |> hd
  end
end
