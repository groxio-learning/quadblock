defmodule Tetris.PointTest do
  use ExUnit.Case
  alias Tetris.Point

  # Author: github: @thejohncotton
  describe "origin/0" do

    test "creates a point tuple with coordinates 0,0" do
      expected = {0, 0}
      actual = Point.origin()
      assert actual == expected
    end
  end

  describe "left/1" do
    @tag :focus
    test "returns a new point tuple with a decremented x value" do
      point = Point.origin()
      expected = {-1, 0}
      actual = point |> Point.left()
      assert actual == expected
    end

    test "returns a new point tuple with an unchanged y value" do
      point = Point.origin()
      {_x, expected} = point
      {_x, actual} = point |> Point.left()
      assert actual == expected
    end
  end

  describe "right/1" do
    test "returns a new point tuple with an incremented x value" do
      point = Point.origin()
      expected = {1, 0}
      actual = point |> Point.right()
      assert actual == expected
    end

    test "returns a new point tuple with an unchanged y value" do
      point = Point.origin()
      {_x, expected} = point
      {_x, actual} = point |> Point.right()
      assert actual == expected
    end
  end

  describe "down/1" do
    test "returns a new point tuple with an incremented y value" do
      point = Point.origin()
      expected = {0, 1}
      actual = point |> Point.down()
      assert actual == expected
    end

    test "returns a new point tuple with an unchanged x value" do
      point = Point.origin()
      {expected, _y} = point
      {actual, _y} = point |> Point.down()
      assert actual == expected
    end
  end
end
