defmodule TbeElixirWeb.FooterPartialTest do
  use TbeElixirWeb.ConnCase, async: true

  test "shows footer", %{conn: conn} do
    conn = get conn, "http://localhost/"
    assert html_response(conn, 200) =~ "Brian Emory 2017"
  end
end
