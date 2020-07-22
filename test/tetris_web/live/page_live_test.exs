defmodule TetrisWeb.PageLiveTest do
  use TetrisWeb.ConnCase

  import Phoenix.LiveViewTest
  alias TetrisWeb.GameLive

  setup do
    socket = build_socket(%{tetro: %{location: {1, 20}}})

    {:ok, socket: socket}
  end

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Phoenix!"
    assert render(page_live) =~ "Welcome to Phoenix!"
  end

  describe "down/1" do
    test "when down is called with location that is top of board, generates new random piece and returns socket",
         %{socket: socket} do
      actual_struct =
        socket
        |> GameLive.down()
        |> attempt_get_struct_type_from_socket_assigns

      expected = Tetris.Tetromino

      assert actual_struct == expected
    end
  end

  describe "handle_info/2" do
    test "when passed socket with tetro in assigns returns that socket with tetro y point incremented by 1 ",
         %{socket: socket} do
      # get a socket with a random piece
      socket_with_tetro =
        socket
        |> GameLive.down()

      # check random piece BEFORE running socket through handle_info
      actual_y_value_before =
        socket_with_tetro
        |> attempt_get_assigns_tetro_y_value

      expected_y_value_before = 1

      assert actual_y_value_before == expected_y_value_before

      # check random piece AFTER running socket through handle_info
      {:noreply, actual_socket_after_handle_info} = GameLive.handle_info(:tick, socket_with_tetro)

      actual_y_value_after =
        actual_socket_after_handle_info
        |> attempt_get_assigns_tetro_y_value

      expected_y_value_after = 2

      assert actual_y_value_after == expected_y_value_after
    end
  end

  defp attempt_get_struct_type_from_socket_assigns(socket) do
    socket
    |> Map.get(:assigns)
    |> Map.get(:tetro)
    |> Map.get(:__struct__)
  end

  defp attempt_get_assigns_tetro_y_value(socket) do
    socket
    |> Map.get(:assigns)
    |> Map.get(:tetro)
    |> Map.get(:location)
    |> Kernel.elem(1)
  end

  defp build_socket(assigns), do: Phoenix.LiveView.Socket.__struct__(assigns: assigns)
end
