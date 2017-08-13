defmodule TbeElixirWeb.PageController do
  use TbeElixirWeb, :controller
  use Timex

  def index(conn, _params) do
    posts = get_blog_posts
    render conn, "index.html", posts: posts
  end

  defp get_blog_posts do
    blog_url = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fmedium.brianemory.com%2Ffeed&api_key=#{System.get_env("RSS2JSON")}&count=3"
json_data = HTTPoison.get!(blog_url)
    %{feed: _, items: items, status: _} = Poison.Parser.parse!(json_data.body, keys: :atoms)
    posts = Enum.map(items, fn(item) ->
      get_post_data(item)
    end)
    require IEx; IEx.pry
  end

  defp get_post_data(item) do
    post = %{
      title:   get_title(item.title),
      date:    get_date(item.pubDate),
      link:    get_link(item.link),
      heading: get_heading(item.content),
      content: get_content(item.content)
    }
  end

  defp get_title(title) do
    title
  end


  defp get_date(date) do
    parsed_date = Timex.parse!(date, "%Y-%m-%d %H:%M:%S", :strftime)
    today = Timex.shift(Timex.to_naive_datetime(Timex.now), days: -1)

    case parsed_date > today do
      true ->
        Timex.from_now(parsed_date)
      false ->
        Timex.format!(new_date, "%b %d, %Y", :strftime)
    end
  end

  defp get_link(link) do
    link
  end

  defp get_heading(content) do
    content
  end

  defp get_content(content) do
    content
  end
end
