defmodule TbeElixirWeb.PageViewTest do
  use TbeElixirWeb.ConnCase, async: true

  test "shows blog, projects, and FAQ on navbar", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Blog"
    assert html_response(conn, 200) =~ "Projects"
    assert html_response(conn, 200) =~ "FAQ"
  end
end
