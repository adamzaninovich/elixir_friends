defmodule ElixirFriends.PostChannel do
  use ElixirFriends.Web, :channel

  def join("posts:new", _auth_msg, socket) do
    {:ok, socket}
  end
end
