defmodule ElixirStream.User do
  use ElixirStream.Web, :model

  schema "users" do
    field :username, :string
    field :password_digest, :string
    field :email, :string
    field :password, :string, virtual: true
    has_many :entries, ElixirStream.Entry
    timestamps
  end


  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid chageset is returned
  with no validation performed.
  """

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:username, min: 5)
    |> validate_length(:username, max: 50)
    |> validate_length(:password, min: 8)
    |> validate_length(:password, max: 100)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> set_password_digest
  end

  defp set_password_digest(base_changeset) do
    case base_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(
          base_changeset, :password_digest, Comeonin.Bcrypt.hashpwsalt(password)
        )
        |> delete_change(:password)
      _ ->
        base_changeset
    end
  end

end
