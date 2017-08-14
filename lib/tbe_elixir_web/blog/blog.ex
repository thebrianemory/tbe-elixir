defmodule TbeElixir.Blog do
  use Timex

  def get_blog_posts do
    blog_url = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fmedium.brianemory.com%2Ffeed&api_key=#{System.get_env("RSS2JSON")}&count=3"
    json_data = HTTPoison.get!(blog_url)
    %{feed: _, items: items, status: _} = Poison.Parser.parse!(json_data.body, keys: :atoms)
    Enum.map(items, fn(item) ->
      get_post_data(item)
    end)
  end

  def get_post_data(item) do
    %{
      title:   get_title(item.title),
      date:    get_date(item.pubDate),
      link:    get_link(item.link),
      heading: get_heading(item.content),
      content: get_content(item.content)
    }
  end

  def get_title(title) do
    title
  end


  def get_date(date) do
    parsed_date = Timex.parse!(date, "%Y-%m-%d %H:%M:%S", :strftime)
    t_minus_1 = Timex.shift(Timex.to_naive_datetime(Timex.now), days: -1)

    case Timex.before?(t_minus_1, parsed_date) do
      true ->
        Timex.from_now(parsed_date)
      false ->
        Timex.format!(parsed_date, "%b %d, %Y", :strftime)
    end
  end

  def get_link(link) do
    Regex.run(~r{[^?]+}, link)
  end

  def get_heading(content) do
    [_, heading] = Regex.replace(~r{(<h4>|<h3>)}, content, "<Z>")
    |> (&Regex.replace(~r{(<\/h4>|<\/h3>)}, &1, "<Z>")).()
    |> (&Regex.run(~r{<Z>(.*?)<Z>}, &1)).()
    heading
  end

  def get_content(content) do
    Regex.replace(~r{\n(<figure>).*(<\/figure>)}, content, "")
    |> (&Regex.replace(~r{(<h4>|<h3>).*(<\/h4>|<\/h3>\n)}, &1, "")).()
    |> (&String.slice(&1, 0..301)).() |> String.replace(~r{\s[^\s]*$}, "")
    |> (&Regex.replace(~r{(<h4>|<h3>).*(<\/h4>\n|<\/h3>\n)}, &1, "")).()
    |> (&HtmlSanitizeEx.strip_tags(&1)).()
    |> (&Regex.replace(~r{(\n)}, &1, " ")).()
    |> Kernel.<>("...")
  end
end
