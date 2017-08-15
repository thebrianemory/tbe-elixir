defmodule TbeElixir.Blog do
  use Timex

  def blog_posts_truncated(url) do
    json_data = HTTPoison.get!(url)
    %{feed: _, items: items, status: _} = Poison.Parser.parse!(json_data.body, keys: :atoms)
    Enum.map(items, fn(item) ->
      post_data_truncated(item)
    end)
  end

  def post_data_truncated(item) do
    %{
      title:   get_title(item.title),
      date:    get_date(item.pubDate),
      link:    get_link(item.link),
      subheading: get_subheading!(item.content),
      content: get_content(item.content),
      categories: get_categories(item.categories)
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

  def get_subheading!(content) do
    subheading = Regex.replace(~r{(<h4>|<h3>)}, content, "<Z>")
    |> (&Regex.replace(~r{(<\/h4>|<\/h3>)}, &1, "<Z>")).()
    |> (&Regex.run(~r{<Z>(.*?)<Z>}, &1)).()

    case subheading do
      nil ->
        ""
      [_, subheading] ->
        subheading
    end
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

  def get_categories(categories) do
    categories
  end
end
