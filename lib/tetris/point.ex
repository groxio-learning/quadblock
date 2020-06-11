defmodule Tetris.Point do
  def origin() do
    {0,0}
  end

  def left({x, y}) do
    {x - 1, y}
  end



end
