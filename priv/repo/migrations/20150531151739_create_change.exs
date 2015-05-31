defmodule Changeling.Repo.Migrations.CreateChange do
  use Ecto.Migration

  def change do
    create table(:changes) do
      add :issue_id, :integer
      add :title, :string
      add :visibility, :string
      add :short_description, :string
      add :change_type, :string
      add :full_description, :string
      add :technical_impact, :string

      timestamps
    end

  end
end
