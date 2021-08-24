defmodule ReachOut.Contributors do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias ReachOut.Contributors.Repo

  @primary_key false

  schema "contributors" do
    field(:owner, :string, primary_key: true)
    field(:repo, :string, primary_key: true)
    field(:email, :string, primary_key: true)
    field(:name, :string)
    field(:sent, :boolean)
    field(:sent_at, :naive_datetime)
    field(:commits, :integer)
    timestamps()
  end

  def changeset(contributor, params \\ %{}) do
    contributor
    |> cast(params, [:owner, :repo, :email, :name, :commits])
    |> validate_required([:owner, :repo, :email, :name, :commits])
    |> validate_format(:email, ~r/@/)
  end

  def create_contributor(attributes) do
    %ReachOut.Contributors{}
    |> ReachOut.Contributors.changeset(attributes)
    |> Repo.insert!()
  end

  def list_unsent_contributors() do
    ReachOut.Contributors
    |> where([c], c.commits >= 5 and c.sent == false)
    |> order_by([c], c.commits)
    |> Repo.all()
  end

  def mark_sent(email) do
    ReachOut.Contributors
    |> where([c], c.email == ^email)
    |> Repo.all()
    |> Enum.each(fn c ->
      change(c, %{sent: true, sent_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)})
      |> Repo.update()
    end)
  end
end
