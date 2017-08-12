defmodule TbeElixirWeb.NavigationPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows blog, projects, and FAQ on navbar", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#blog\">"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#projects\">"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#faq\">"
  end
end
