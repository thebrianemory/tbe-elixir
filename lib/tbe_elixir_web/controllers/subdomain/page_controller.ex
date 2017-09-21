defmodule TbeElixirWeb.Subdomain.PageController do
  use TbeElixirWeb, :controller

  def index(conn, _params) do
    text(conn, "Subdomain home page for #{conn.private[:subdomain]}")
  end

end
