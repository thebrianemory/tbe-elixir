defmodule TbeElixirWeb.PageControllerTest do
  use TbeElixirWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Brian Emory"
  end
end
