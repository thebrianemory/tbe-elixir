defmodule TbeElixirWeb.PageController do
  use TbeElixirWeb, :controller

  alias TbeElixir.Blog

  def index(conn, _params) do
    posts = Blog.get_blog_posts()
    render conn, "index.html", posts: posts
  end
end
