defmodule TbeElixirWeb.PageController do
  use TbeElixirWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
