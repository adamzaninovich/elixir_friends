defmodule ElixirFriends.Router do
  use ElixirFriends.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ElixirFriends do
    pipe_through :browser

    get "/", PostController, :index
    resources "/posts", PostController
  end
end
