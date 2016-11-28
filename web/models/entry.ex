defmodule ElixirStream.Entry do
  use ElixirStream.Web, :model

  schema "entries" do
    field :email, :string
    field :author_name, :string
    field :title, :string, default: ""
    field :tweet_message, :string
    field :scheduled_time, Ecto.DateTime
    field :tweet_posted, :boolean
    field :body, :string
    field :slug, :string
    belongs_to :user, ElixirStream.User
    timestamps
  end

  @optional_fields ~w(email author_name tweet_posted tweet_message scheduled_time user_id)
  @required_fields ~w(title body)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset_without_user(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:author_name, min: 5)
    |> validate_length(:title, min: 5)
    |> validate_length(:body, min: 15)
    |> validate_length(:body, max: 500)
    |> unique_constraint(:title, on: ElixirStream.Repo)
    |> set_slug
  end

  def changeset_with_admin(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 5)
    |> validate_length(:body, min: 15)
    |> validate_length(:body, max: 500)
    |> validate_length(:tweet_message, min: 10)
    |> validate_length(:tweet_message, max: 140)
    |> set_slug
  end

  def changeset_with_user(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 5)
    |> validate_length(:body, min: 15)
    |> validate_length(:body, max: 500)
    |> unique_constraint(:title, on: ElixirStream.Repo)
    |> set_slug
  end

  def set_slug(changeset) do
    slug =
      Ecto.Changeset.get_field(changeset, :title)
      |> String.trim
      |> String.downcase
      |> String.replace(~r/([^a-z0-9])+/, "-")
    put_change(changeset, :slug, slug)
  end
end
