defmodule ElixirStream.FeedView do
  use ElixirStream.Web, :view
  alias ElixirStream.Entry
  use Timex

  def parse_markdown(markdown), do: Earmark.to_html(markdown)

  def date_format(entry) do
    {:ok, date} =
      Timezone.convert(entry.inserted_at, "UTC")
      |> Timex.format("%a, %d %b %Y %H:%M:%S %z", :strftime)
    date
  end

end
