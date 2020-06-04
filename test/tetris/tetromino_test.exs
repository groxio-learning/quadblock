defmodule Tetris.TetrominoTest do
  use ExUnit.Case
  alias Tetris.Tetromino

  # Author: github - @brettwise
  describe "new" do
    test "passing no arguments returns a Tetromino struct w/ nil values" do
      actual = Tetromino.new()
      expected = %Tetromino{}

      assert actual == expected
    end

    test "passing a keyword lists of Tetromino keys and values returns a struct with those keys and values" do
      actual = Tetromino.new(shape: :i, rotation: 270, location: {1, 1})
      expected = %Tetromino{shape: :i, rotation: 270, location: {1, 1}}

      assert actual == expected
    end
  end

  describe "new_random" do
    @tag :focus
    test "returns a tetromino struct with one of seven possible shapes" do
      new_random = Tetromino.new_random()
      possible_shapes = [:i, :t, :o, :l, :j, :z, :s]

      assert Enum.member?(possible_shapes, new_random.shape)
    end
  end

  describe "right" do
    test "takes a tetro and returns a tetro with an updated location where the x value has 1 added" do
      actual = Tetromino.right(Tetromino.new())
      expected = %Tetromino{location: {6, 1}}

      assert actual == expected
    end
  end

  describe "left" do
    test "takes a tetro and returns a tetro with an updated location where the x value has 1 subtracted" do
      actual = Tetromino.left(Tetromino.new())
      expected = %Tetromino{location: {4, 1}}

      assert actual == expected
    end
  end

  describe "down" do
    test "takes a tetro and returns a tetro with an updated location where the y value has 1 added" do
      actual = Tetromino.down(Tetromino.new())
      expected = %Tetromino{location: {5, 2}}

      assert actual == expected
    end
  end

  # Author: github - @thejohncotton
  describe "rotate/1" do
    test "returns a new tetronimo rotated 90 degrees clockwise" do
      tetro = Tetromino.new()
      rotated_tetronimo = tetro |> Tetromino.rotate()
      expected = 90
      actual = rotated_tetronimo.rotation
      assert actual == expected
    end

    test "returns a new tetronimo with a rotation of 0 when input rotation is 270" do
      tetro = Tetromino.new(%{rotation: 270})
      rotated_tetronimo = tetro |> Tetromino.rotate()
      expected = 0
      actual = rotated_tetronimo.rotation
      assert actual == expected
    end
  end
end
