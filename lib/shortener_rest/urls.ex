defmodule ShortenerRest.URLs do
	alias ShortenerRest.URLs.URL
  alias ShortenerRest.Repo
  import Ecto.Query

  @alphabet 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

  defp random_string(existing) do
    <<i1::size(32), i2::size(32), i3::size(32)>> =
      :crypto.strong_rand_bytes(12)

    :rand.seed(:exsp, {i1, i2, i3})
    short = for _ <- 1..5, into: "", do: <<Enum.random(@alphabet)>>

    short in existing && random_string(existing) || short
  end

  def add(%{url: url, days: days}) do
    existing = Repo.all(
      from u in URL,
        select: u.shortkey
    )

    short = random_string(existing)

    %URL{}
    |> URL.changeset(%{url: url, shortkey: short, days: days})
    |> Repo.insert()

    short
  end
  
  def get(short) do
    res = Repo.one(
      from u in URL,
        where: u.shortkey == ^short,
        select: u
    )

    if res do
      utc = NaiveDateTime.utc_now()

      if NaiveDateTime.diff(utc, res.inserted_at, :day) >= res.days do
        Repo.delete(res)
        {:err, :eol}
      else
        {:ok, res.url}
      end
    else
      {:err, :not_found}
    end
  end
end