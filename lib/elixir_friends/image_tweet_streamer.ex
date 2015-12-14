defmodule ElixirFriends.ImageTweetStreamer do

  def stream(search_term) do
    ExTwitter.stream_filter(track: search_term)
    |> Stream.filter(&has_images?/1)
    |> Stream.map(&store_tweet/1)
  end

  defp has_images?(tweet) do
    Map.has_key?(tweet.entities, :media) &&
    (tweet |> photos |> Enum.any?)
  end

  defp store_tweet(tweet) do
    %ElixirFriends.Post{
      image_url: first_photo(tweet).media_url,
      content: tweet.text,
      source_url: first_photo(tweet).expanded_url }
    |> ElixirFriends.Repo.insert
  end

  defp photos(tweet) do
    tweet.entities.media
    |> Enum.filter(&(&1.type == "photo"))
  end

  defp first_photo(tweet) do
    tweet |> photos |> hd
  end
end
