defmodule Tay.API.PostController do
  use Tay.Web, :controller

  alias Tay.Post

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, params) do
    page = Post
    |> Post.sorted
    |> Repo.paginate(params)
    render conn, "index.json", page: page
  end
end
