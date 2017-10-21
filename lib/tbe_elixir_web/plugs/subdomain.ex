defmodule TbeElixirWeb.Plug.Subdomain do
  import Plug.Conn

  @doc false
  def init(default), do: default

  @doc """
  This plug ensures that the subdomain of "www" gets routed to the standard page_controller, subdomains of "til" get routed to the subdomain page_controller, no subdomain also goes to the standard page_controller, and everything else goes to a 404.
  """
  def call(conn, router) do
    case get_subdomain(conn.host) do
      subdomain when byte_size(subdomain) == 0 -> conn
      subdomain when subdomain == "www" -> conn |> put_private(:subdomain, subdomain)
      subdomain when subdomain == "til" ->
        conn
        |> put_private(:subdomain, subdomain)
        |> router.call(router.init({}))
        |> halt
      subdomain -> conn |> put_private(:subdomain, subdomain <> "no luck")
    end
  end

  defp get_subdomain(host) do
    root_host = TbeElixirWeb.Endpoint.config(:url)[:host]
    String.replace(host, ~r/.?#{root_host}/, "")
  end
end
