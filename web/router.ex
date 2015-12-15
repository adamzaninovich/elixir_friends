defmodule Tay.Router do
  use Tay.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tay do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Tay do
    pipe_through :api

    resources "/posts", API.PostController, only: [:index]
  end
end
