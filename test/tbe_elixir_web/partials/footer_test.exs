defmodule TbeElixirWeb.FooterPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows footer", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Brian Emory 2017"
  end
end
