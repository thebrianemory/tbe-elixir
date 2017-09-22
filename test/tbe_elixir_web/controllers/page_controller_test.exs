defmodule TbeElixirWeb.PageControllerTest do
  use TbeElixirWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "http://localhost:4000/"
    assert html_response(conn, 200) =~ "Brian Emory"
  end
end
