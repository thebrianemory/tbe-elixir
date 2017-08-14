defmodule TbeElixirWeb.FAQPartialTest do
  use TbeElixirWeb.ConnCase

  test "shows heading for FAQ", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<section class=\"faq-section\" id=\"faq\">"
  end

  test "shows GitHub button", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "How tall are you?"
  end
end
