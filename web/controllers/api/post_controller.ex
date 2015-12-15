defmodule ElixirFriends.API.PostController do
  use ElixirFriends.Web, :controller
  alias ElixirFriends.Post

  def index(conn, params) do
    page = Post
    |> Post.sorted
    |> Repo.paginate(params)
    render conn, "index.json", page: page
  end
end
