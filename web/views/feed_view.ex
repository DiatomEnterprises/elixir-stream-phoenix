defmodule ElixirStream.FeedView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry
  use Timex

  def parse_markdown(markdown), do: Earmark.to_html(markdown)

  def date_format(entry) do
    {:ok, date} = Timex.format(entry.inserted_at, "%a, %d %b %Y %H:%M:%S %z", :strftime)
    date
  end

end
