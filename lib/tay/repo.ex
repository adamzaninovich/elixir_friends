defmodule Tay.Repo do
  use Ecto.Repo, otp_app: :tay
  use Scrivener, page_size: 20
end
