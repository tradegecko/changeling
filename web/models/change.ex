defmodule Changeling.Change do
  use Changeling.Web, :model

  schema "changes" do
    field :issue_id, :integer
    field :title, :string
    field :visibility, :string
    field :short_description, :string
    field :change_type, :string
    field :full_description, :string
    field :technical_impact, :string
    field :authors, :string
    field :deployed_on, :date

    timestamps
  end

  @required_fields ~w(title visibility short_description change_type authors)
  @optional_fields ~w(issue_id  full_description technical_impact deployed_on)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def public(query) do
    from p in query,
    where: p.visibility == "Public"
  end
end
