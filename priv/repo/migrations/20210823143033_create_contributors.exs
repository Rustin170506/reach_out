defmodule ReachOut.Contributors.Repo.Migrations.CreateContributors do
  use Ecto.Migration

  def change do
    create table(:contributors, primary_key: false) do
      add :email, :string, null: false, primary_key: true
      add :name, :string, null: false
      add :sent, :boolean, default: false
      add :sent_at, :naive_datetime
      timestamps()
    end
  end
end
