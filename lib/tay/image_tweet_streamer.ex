defmodule Tay.ImageTweetStreamer do
  import Ecto.Query, only: [from: 2]
  alias Tay.Post
  alias Tay.Repo

  def stream(search_term) do
    ExTwitter.stream_filter(track: search_term)
    |> Stream.filter(&has_images?/1)
    |> Stream.map(&handle_tweet/1)
  end

  defp has_images?(tweet) do
    Map.has_key?(tweet.entities, :media) &&
    (tweet |> photos |> Enum.any?)
  end

  defp photos(tweet) do
    tweet.entities.media
    |> Enum.filter(&(&1.type == "photo"))
  end

  defp handle_tweet(tweet) do
    %Post{
      image_url: first_photo(tweet).media_url,
      content: tweet.text,
      source_url: first_photo(tweet).expanded_url,
      username: tweet.user.screen_name }
    |> reject_existing
    |> broadcast_post
    |> store_post
  end

  defp first_photo(tweet) do
    tweet |> photos |> hd
  end

  defp reject_existing(post) do
    (from p in Post,
      where: p.image_url == ^post.image_url,
      select: count(p.id))
    |> Repo.one
    |> case do
      0 -> post
      _ -> nil
    end
  end

  defp broadcast_post(nil), do: nil
  defp broadcast_post(post) do
    Tay.Endpoint.broadcast!("posts:new", "new:post", post)
    post
  end

  defp store_post(nil), do: nil
  defp store_post(post), do: Repo.insert(post)
end
