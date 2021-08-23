defmodule ReachOut.Contributors do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReachOut.Contributors.Repo

  @primary_key {:email, :string, autogenerate: false}
  schema "contributors" do
    field(:name, :string)
    field(:sent, :boolean)
    field(:sent_at, :naive_datetime)
    timestamps()
  end

  def changeset(contributor, params \\ %{}) do
    contributor
    |> cast(params, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def create_contributor(attributes) do
    %ReachOut.Contributors{}
    |> ReachOut.Contributors.changeset(attributes)
    |> Repo.insert!()
  end
end
