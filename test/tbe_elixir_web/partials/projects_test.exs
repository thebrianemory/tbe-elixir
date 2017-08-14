defmodule TbeElixirWeb.ProjectsPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows heading", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<section class=\"projects-section\" id=\"projects\">"
  end

  test "shows GitHub button", %{conn: conn} do
    conn = get conn, "/"
    message = "<a class=\"btn btn-xs custom-btn\" href=\"https://github.com/thebrianemory/vidshare\" target=\"_blank\">GitHub</a>"
    assert html_response(conn, 200) =~ message
  end
end

