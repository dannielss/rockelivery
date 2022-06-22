defmodule Rockelivery.Users.GetAll do
  alias Rockelivery.{Error, Repo, User}

  def call() do
    case Repo.all(User) do
      nil -> {:error, Error.build(:internal_server_error, "Internal server error")}
      users -> {:ok, users}
    end
  end
end
