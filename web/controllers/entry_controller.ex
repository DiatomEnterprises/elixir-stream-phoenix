defmodule ElixirStream.EntryController do
  use ElixirStream.Web, :controller
  alias ElixirStream.Entry

  plug :scrub_params, "entry" when action in [:create, :update]

  def index(conn, _params) do
    entries = Repo.all from e in Entry, order_by: [desc: e.id], preload: [:user]
    render conn, "index.html", entries: entries
  end

  def new(conn, _params) do
    changeset = Entry.changeset_with_user(%Entry{})
    render conn, "new.html", changeset: changeset
  end

  def create(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"entry" => entry_params}) do
    case ElixirStream.CreateEntryActionForExistingUser.persist(entry_params, current_user, conn) do
      {:ok, %Entry{} = _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def create(conn, %{"entry" => entry_params}) do
    case ElixirStream.CreateEntryActionForGuestUser.persist(entry_params, conn) do
      {:ok, %Entry{} = _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => slug}) do
    entry = Repo.one(from(e in Entry, where: e.slug == ^slug, preload: [:user]))
    render conn, "show.html", entry: entry
  end

  def delete(conn, %{"id" => id}) do
    user = get_session(conn, :user_id)
    entry = Repo.one(from(e in Entry, where: e.id == ^id and e.user_id  == ^user ))
    if entry do
      Repo.delete(entry)
      message = "Entry deleted successfully."
    else
      message = "Access denied"
    end
    conn
    |> put_flash(:info, message)
    |> redirect(to: entry_path(conn, :index))
  end

end
