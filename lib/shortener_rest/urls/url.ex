defmodule ShortenerRest.URLs.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :days, :integer
    field :shortkey, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url, :shortkey, :days])
    |> validate_required([:url, :shortkey, :days])
  end
end
