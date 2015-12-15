defmodule Tay.DatabaseCleaner do
  @moduledoc """
  Deletes all but last 100 posts form the DB every 5 minutes
  """
  use GenServer
  import Ecto.Query, only: [from: 2]
  alias Tay.Post
  alias Tay.Repo
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self, :delete_some_posts, 15 * 1000)
    {:ok, state}
  end

  def handle_info(:delete_some_posts, state) do
    if total_posts > 100 do
      {n, _} = delete_posts
      Logger.debug "Deleted #{n} old posts"
    end
    Process.send_after(self, :delete_some_posts, 5 * 60 * 1000)
    {:noreply, state}
  end

  defp total_posts do
    (from p in Post,
      select: count(p.id))
    |> Repo.one
  end

  defp delete_posts do
    (from p in Post,
      where: p.id < ^delete_before)
    |> Repo.delete_all
  end

  defp delete_before do
    (from p in Post,
      select: p.id,
      limit: 100,
      order_by: [desc: p.id])
    |> Repo.all
    |> Enum.reverse
    |> hd
  end
end
