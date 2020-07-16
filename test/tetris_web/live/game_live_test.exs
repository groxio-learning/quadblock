defmodule TetrisWeb.GameLiveTest do
  use TetrisWeb.ConnCase
  alias TetrisWeb.GameLive
  alias Tetris.Tetromino
  import Phoenix.LiveViewTest

  describe "setup conn" do

  end
  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/game")
    view = page_live
    assert disconnected_html =~ "Welcome to Tetris"
    assert render(view) =~ "Welcome to Tetris"

  end

  test "renders game header", %{conn: conn} do
    {:ok, view, _disconnected_html} = live(conn, "/game")

    assert view
      |> element(".phx-hero")
      |> has_element?
    assert view
      |> element(".phx-hero")
      |> render() =~ "Welcome to Tetris</h1>"

  end

  test "displays point origin location correctly", %{conn: conn} do
    {:ok, view, _disconnected_html} = live(conn, "/game")
    assert view
    |> render() =~ "{5, 1}"
  end

end
