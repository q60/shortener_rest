defmodule ShortenerRest.Repo do
  use Ecto.Repo,
    otp_app: :shortener_rest,
    adapter: Ecto.Adapters.Postgres
end
