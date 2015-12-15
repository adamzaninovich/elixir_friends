defmodule Tay.API.PostView do
  use Tay.Web, :view

  def render("index.json", %{page: page}) do
    page
  end
end
