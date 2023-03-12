defmodule ShortenerRest.APIContext do
  @headers [
    "API-OPR": Application.compile_env(:shortener_rest, :opr_api_key)
  ]

  def get_days(url) do
    query =
      %{"domains[0]" => url}
      |> URI.encode_query()

    days =
      HTTPoison.get!(
        "https://openpagerank.com/api/v1.0/getPageRank?" <> query,
        @headers
      ).body
      |> Jason.decode!()
      |> Map.fetch!("response")
      |> hd()
      |> Map.fetch!("page_rank_integer")

    days == 0 && 1 || days
  end
end
