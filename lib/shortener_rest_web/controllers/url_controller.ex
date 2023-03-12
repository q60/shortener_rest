defmodule ShortenerRestWeb.URLController do
  use ShortenerRestWeb, :controller
  alias ShortenerRest.APIContext
  alias ShortenerRest.URLs

  def create(conn, %{"url" => url}) do
    days = APIContext.get_days(url)
    short = URLs.add(%{url: url, days: days})

    conn
    |> put_status(:created)
    |> json(%{"short" => short, "days" => days})
  end

  def get(conn, %{"shortkey" => short}) do
    case URLs.get(short) do
      {:ok, url} ->
        conn
        |> put_status(:found)
        |> json(%{"url" => url})
      _ ->
        conn
        |> put_status(:not_found)
        |> json(%{"url" => "not_found"})
    end
  end
end
