defmodule Tay.Post do
  use Tay.Web, :model

  schema "posts" do
    field :image_url, :string
    field :content, :string
    field :source_url, :string
    field :username, :string

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(image_url content source_url), [])
  end

  def sorted(query) do
    from p in query, order_by: [desc: p.inserted_at]
  end
end

defimpl Poison.Encoder, for: Tay.Post do
  def encode(post, _options) do
    post
    |> Map.take([:image_url, :content, :source_url, :username, :inserted_at])
    |> Poison.encode!
  end
end
