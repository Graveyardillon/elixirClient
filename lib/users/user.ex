defmodule Httpclient.Users.User do
    use Ecto.Schema
  
    schema "User" do
      field :username, :string
    end

    def changeset(person, params \\ %{}) do
        person
        |> Ecto.Changeset.cast(params, [:username])
        |> Ecto.Changeset.validate_required([:username])
    end
  end