defmodule Users.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:User) do
      add :username,:string
    end
  end
end
