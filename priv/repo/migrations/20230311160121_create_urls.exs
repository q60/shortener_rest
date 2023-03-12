defmodule ShortenerRest.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :url, :string
      add :shortkey, :string
      add :days, :integer

      timestamps()
    end
  end
end
