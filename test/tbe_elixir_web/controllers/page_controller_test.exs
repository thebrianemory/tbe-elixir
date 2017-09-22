defmodule TbeElixirWeb.PageControllerTest do
  use TbeElixirWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "http://localhost/"
    assert html_response(conn, 200) =~ "Brian Emory"
  end
end
