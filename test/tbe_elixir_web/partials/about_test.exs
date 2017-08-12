defmodule TbeElixirWeb.AboutPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows \"Hi, I'm Brian Emory\"", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hi, I'm Brian Emory"
  end

  test "shows my photo", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<img alt=\"Me at beach\" class=\"about-pic img-responsive\" src=\"/images/me_at_beach.jpg\">"
  end
end
