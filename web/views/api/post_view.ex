defmodule ElixirFriends.API.PostView do
  use ElixirFriends.Web, :view

  def render("index.json", %{page: page}) do
    page
    |> Poison.encode!
  end
end
