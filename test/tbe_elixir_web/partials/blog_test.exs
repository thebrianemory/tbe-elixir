defmodule TbeElixirWeb.BlogPartialTest do
  use TbeElixirWeb.ConnCase, async: true

  test "shows heading", %{conn: conn} do
    conn = get conn, "http://localhost/"
    assert html_response(conn, 200) =~ "<section class=\"blog-section\" id=\"blog\">"
  end

  test "shows link to Medium", %{conn: conn} do
    conn = get conn, "http://localhost/"
    assert html_response(conn, 200) =~ "<a class=\"btn custom-btn\" href=\"https://medium.brianemory.com\" target=\"_blank\">"
  end
end
