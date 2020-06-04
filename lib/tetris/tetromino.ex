defmodule Tetris.Tetromino do
  defstruct shape: :l, rotation: 0, location: {5, 1}

  def new() do
    %Tetris.Tetromino{}
  end

  def new(attrs) when is_list(attrs) do
    __struct__(attrs)
  end

  def new_random() do
    %Tetris.Tetromino{shape: _shape()}
  end

  defp _shape() do
    [:i, :t, :o, :l, :j, :z, :s] |> Enum.random()
  end
end
