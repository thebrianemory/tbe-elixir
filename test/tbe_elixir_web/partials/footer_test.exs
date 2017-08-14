defmodule TbeElixirWeb.FooterPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows footer", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<p>© Brian Emory 2017</p>"
  end
end
