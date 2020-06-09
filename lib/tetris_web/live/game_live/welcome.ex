defmodule TetrisWeb.GameLive.Welcome do
  use TetrisWeb, :live_view
  alias Tetris.Game
  
  def mount(_params, _session, socket) do
    {
      :ok, 
      assign(socket, game: Map.get(socket.assigns, :game) || Game.new)
    }
  end
  
  defp play(socket) do
    push_redirect(socket, to: "/game/playing")
  end
  
  def handle_event("play", _, socket) do
    {:noreply, play(socket)}
  end
end