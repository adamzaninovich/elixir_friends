require IEx
defmodule ElixirFriends.PostView do
  use ElixirFriends.Web, :view
  use Timex
  import Scrivener.HTML, except: [pagination_links: 2]

  def pagination_links(page, opts) do
    content_tag(:div, build_links(page, opts), class: "ui pagination menu")
  end

  def build_links(page, opts) do
    raw_pagination_links(page, opts)
    |> Enum.map(fn({text, number}) ->
      link("#{text}", to: "?page=#{number}", class: classes(page.page_number, number))
    end)
  end

  def classes(n, n), do: "active item"
  def classes(_n, _c), do: "item"
end
