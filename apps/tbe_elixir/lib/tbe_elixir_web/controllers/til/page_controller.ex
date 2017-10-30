defmodule TbeElixirWeb.Til.PageController do
  use TbeElixirWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {TbeElixirWeb.LayoutView, "til.html"}
  end
end
