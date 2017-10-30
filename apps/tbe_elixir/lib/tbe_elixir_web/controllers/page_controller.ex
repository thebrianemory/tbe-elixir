defmodule TbeElixirWeb.PageController do
  use TbeElixirWeb, :controller

  def index(conn, _params) do
    blog_url = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fmedium.brianemory.com%2Ffeed&api_key=#{System.get_env("RSS2JSON")}&count=3"
    posts = GetMedium.Truncated.blog_posts(blog_url)
    render conn, "index.html", posts: posts
  end
end
