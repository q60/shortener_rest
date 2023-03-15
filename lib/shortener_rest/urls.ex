defmodule ShortenerRest.URLs do
  alias ShortenerRest.URLs.URL
  alias ShortenerRest.Repo
  import Ecto.Query

  @alphabet 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

  defp random_string() do
    <<i1::size(32), i2::size(32), i3::size(32)>> = :crypto.strong_rand_bytes(12)

    :rand.seed(:exsp, {i1, i2, i3})

    for _ <- 1..5, into: "", do: <<Enum.random(@alphabet)>>
  end

  def add(%{url: url, days: days} = map) do
    short = random_string()

    result =
      %URL{}
      |> URL.changeset(%{url: url, shortkey: short, days: days})
      |> Repo.insert()

    case result do
      {:ok, _} -> short
      {:error, _} -> add(map)
    end
  end

  def get(short) do
    res =
      Repo.one(
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
