defmodule ElixirFriends.Post do
  use ElixirFriends.Web, :model

  schema "posts" do
    field :image_url, :string
    field :content, :string
    field :source_url, :string
    field :username, :string

    timestamps
  end

  @required_fields ~w(image_url content source_url)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def sorted(query) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end

  def limit(query, number \\ 10) do
    from p in query,
    limit: ^number
  end
end
