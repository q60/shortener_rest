defmodule ShortenerRest.APIContext do
  @headers [
    "API-OPR": Application.compile_env(:shortener_rest, :opr_api_key)
  ]

  def get_days(url) do
    query =
      %{"domains[0]" => url}
      |> URI.encode_query()

    json =
      HTTPoison.get!(
        "https://openpagerank.com/api/v1.0/getPageRank?" <> query,
        @headers
      ).body
      |> Jason.decode!()

    with {:ok, response} <- Map.fetch(json, "response"),
         {:ok, days} <- Map.fetch(hd(response), "page_rank_integer") do
      {:ok, if(days == 0, do: 1, else: days)}
    else
      _ -> {:error, "OPR API error"}
    end
  end
end
