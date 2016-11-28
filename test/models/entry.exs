defmodule ElixirStream.EntryTest do
  use ElixirStream.ModelCase
  alias ElixirStream.Entry

  describe "changeset_without_user" do
    @valid_attrs %{
      author_name:  "janjiss",
      email: "janjiss@gmail.com",
      title: "qwerty123",
      body: "body body    body"
    }
    test "success" do
      changeset = Entry.changeset_without_user(%Entry{}, @valid_attrs)
      assert changeset.valid?
    end

    test "failed" do
      changeset = Entry.changeset_without_user(%Entry{}, %{})
      refute changeset.valid?
      assert {:author_name, "can't be blank"} in errors_on(changeset)
      assert {:title, "can't be blank"} in errors_on(changeset)
      assert {:email, "can't be blank"} in errors_on(changeset)
      assert {:body, "can't be blank"} in errors_on(changeset)
    end
  end

  describe "changeset_with_admin" do
    @valid_attrs %{
      author_name:  "janjiss",
      email: "janjiss@gmail.com",
      title: "qwerty123",
      body: "body body    body",
      tweet_posted: true,
      tweet_message: "tweet_message",
      scheduled_time: Timex.now
    }

    test "success" do
      changeset = Entry.changeset_with_admin(%Entry{}, @valid_attrs)
      assert changeset.valid?
    end

    test "failed" do
      changeset = Entry.changeset_with_admin(%Entry{}, %{})
      refute changeset.valid?
      assert {:author_name, "can't be blank"} in errors_on(changeset)
      assert {:title, "can't be blank"} in errors_on(changeset)
      assert {:body, "can't be blank"} in errors_on(changeset)
    end
  end

  describe "changeset_with_user" do
    @valid_attrs %{
      author_name:  "janjiss",
      email: "janjiss@gmail.com",
      title: "qwerty123",
      body: "body body    body",
      user_id: 1
    }

    test "success" do
      changeset = Entry.changeset_with_user(%Entry{}, @valid_attrs)
      assert changeset.valid?
    end

    test "failed" do
      changeset = Entry.changeset_with_user(%Entry{}, %{})
      assert {:user_id, "can't be blank"} in errors_on(changeset)
      assert {:author_name, "can't be blank"} in errors_on(changeset)
      assert {:title, "can't be blank"} in errors_on(changeset)
      assert {:body, "can't be blank"} in errors_on(changeset)
    end
  end

  describe "set_slug" do

    @valid_attrs %{
      author_name:  "janjiss",
      email: "janjiss@gmail.com",
      title: "qwerty 123 // ---\n<|>",
      body: "body body    body",
    }

    test "success" do
      changeset = Entry.changeset_with_user(%Entry{}, @valid_attrs)
      assert(changeset.changes.slug == "qwerty-123-")
    end
  end
end
