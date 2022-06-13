defmodule AppWeb.Api.SessionControllerTest do
  use AppWeb.ConnCase, async: true
  import App.AccountsFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "POST /api/session" do
    test "with no credentials user can't login", %{conn: conn} do
      conn = post(conn, Routes.api_session_path(conn, :create), email: nil, password: nil)

      assert %{"message" => "User could not be authenticated [Missing user email]"} =
               json_response(conn, 401)
    end

    test "with invalid password user can't login", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.api_session_path(conn, :create),
          email: user.email,
          username: user.username,
          password: "badpassword"
        )

      assert %{"message" => "User could not be authenticated " <> _} = json_response(conn, 401)
    end

    test "unconfirmed user can't login", %{conn: conn} do
      user = user_fixture(confirmed: false)

      conn =
        post(conn, Routes.api_session_path(conn, :create),
          email: user.email,
          username: user.username,
          password: "badpassword"
        )

      assert %{"message" => "User could not be authenticated " <> _} = json_response(conn, 401)
    end

    test "with valid password user can login", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.api_session_path(conn, :create),
          email: user.email,
          username: user.username,
          password: user.password
        )

      assert %{
               "data" => %{"token" => "" <> _},
               "message" => "You are successfully logged in" <> _
             } = json_response(conn, 200)
    end
  end
end
