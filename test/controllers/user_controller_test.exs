defmodule ElixirStream.UserControllerTest do
  use ElixirStream.ConnCase

  test "GET /register_form", %{conn: conn} do
    resp_conn = get(conn, "/register_form")
    assert html_response(resp_conn, 200) =~ "Username"
  end

  test "POST /registers", %{conn: conn} do
    resp_conn = post(conn, "/register", user: %{})
    assert html_response(resp_conn, 200) =~ "Username"
  end
end
