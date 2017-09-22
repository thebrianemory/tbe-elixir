defmodule TbeElixirWeb.Plug.Subdomain do
  import Plug.Conn

  @doc false
  def init(default), do: default

  @doc """
  This plug ensures that the subdomain of "www" gets routed to the standard page_controller, subdomains of "til" get routed to the subdomain page_controller, no subdomain also goes to the standard page_controller, and everything else goes to a 404.
  """
  def call(conn, router) do
    case get_subdomain(conn.host) do
      subdomain when subdomain == "www" -> conn
      subdomain when subdomain == "til" ->
        conn
        |> router.call(router.init({}))
        |> halt
      subdomain when byte_size(subdomain) == 0 ->
        conn
      _->
        conn
        |> Phoenix.Controller.render(TbeElixirWeb.ErrorView, "404.html")
        |> halt
    end
  end

  defp get_subdomain(host) do
    root_host = TbeElixirWeb.Endpoint.config(:url)[:host]
    String.replace(host, ~r/.?#{root_host}/, "")
  end
end
