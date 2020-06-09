defmodule TetrisWeb.GameLive.Playing do
  use TetrisWeb, :live_view
  alias Tetris.Game
  
  @rotate_keys ["ArrowUp", " "]
  
  def mount(_params, _session, socket) do
    if connected?(socket) do 
      :timer.send_interval(50, :tick)
    end
    
    {:ok, new_game(socket)}
  end
  
  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end
  
  defp render_points(assigns) do
    ~L"""
    <%= for {x, y, shape} <- @game.points ++ Game.junkyard_points(@game) do %>
      <rect 
        width="20" height="20" 
        x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>" 
        style="fill:<%= color(shape) %>;" />
    <% end %>
    """
  end
  
  defp color(:l), do: "red"
  defp color(:j), do: "royalblue"
  defp color(:s), do: "limegreen"
  defp color(:z), do: "yellow"
  defp color(:o), do: "magenta"
  defp color(:i), do: "silver"
  defp color(:t), do: "saddlebrown"
  defp color(_), do: "red"
  
  defp new_game(socket) do
    assign(socket, game: Game.new())
  end
  
  def rotate(%{assigns: %{game: game}}=socket) do
    assign(socket, game: Game.rotate(game))
  end

  def left(%{assigns: %{game: game}}=socket) do
    assign(socket, game: Game.left(game))
  end

  def right(%{assigns: %{game: game}}=socket) do
    assign(socket, game: Game.right(game))
  end

  def down(%{assigns: %{game: game}}=socket) do
    assign(socket, game: Game.down(game))
  end
  
  def maybe_end_game(%{assigns: %{game: %{game_over: true}}}=socket) do
    socket
    |> push_redirect(to: "/game/over?score=#{socket.assigns.game.score}")
  end
  def maybe_end_game(socket), do: socket
  
  def handle_info(:tick, socket) do
    {
      :noreply, 
      socket 
      |> down
      |> maybe_end_game
    }
  end
  
  def handle_event("keystroke", %{"key" => key}, socket) when key in @rotate_keys do
    {:noreply, socket |> rotate}
  end
  
  def handle_event("keystroke", %{"key" => "ArrowRight"}, socket) do
    {:noreply, socket |> right}
  end

  def handle_event("keystroke", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, socket |> left}
  end
  
  def handle_event("keystroke", _, socket) do
    {:noreply, socket}
  end
end