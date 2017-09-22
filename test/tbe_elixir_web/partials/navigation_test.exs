defmodule TbeElixirWeb.NavigationPartialTest do
  use TbeElixirWeb.ConnCase, async: true

  test "shows blog, projects, and FAQ on navbar", %{conn: conn} do
    conn = get conn, "http://localhost/"
    assert html_response(conn, 200) =~ "<a class=\"navbar-brand page-scroll nav-text blue-text\" href=\"#page-top\">"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#blog\">"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#projects\">"
    assert html_response(conn, 200) =~ "<a class=\"page-scroll blue-text\" href=\"#faq\">"
    assert html_response(conn, 200) =~ "<a href=\"https://twitter.com/thebrianemory\" target=\"_blank\">"
    assert html_response(conn, 200) =~ "<a href=\"https://www.linkedin.com/in/thebrianemory\" target=\"_blank\">"
    assert html_response(conn, 200) =~ "<a href=\"https://github.com/thebrianemory\" target=\"_blank\">"
  end
end
