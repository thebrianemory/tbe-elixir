defmodule TbeElixirWeb.Subdomain.PageControllerTest do
  use TbeElixirWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "http://til.localhost/"
    assert html_response(conn, 200) =~ "TIL"
  end
end
