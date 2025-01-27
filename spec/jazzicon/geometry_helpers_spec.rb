# frozen_string_literal: true

require "chunky_png"
require_relative "../../lib/jazzicon/helpers/geometry_helpers"

RSpec.describe Jazzicon::GeometryHelpers do
  let(:diameter) { 100 }
  let(:shape_count) { 4 }

  describe ".calculate_corners" do
    it "calculates the four corners of a rectangle correctly" do
      point = Jazzicon::Point.new(x: 200, y: 150)
      size = Jazzicon::Size.new(width: 100, height: 50)

      expected_corners = [
        Jazzicon::Point.new(x: 150, y: 125), # Top-left
        Jazzicon::Point.new(x: 250, y: 125), # Top-right
        Jazzicon::Point.new(x: 250, y: 175), # Bottom-right
        Jazzicon::Point.new(x: 150, y: 175)  # Bottom-left
      ]

      corners = described_class.calculate_corners(point, size)

      expect(corners).to eq(expected_corners)
    end
  end

  describe ".rotate_corners" do
    it "rotates the corners of a rectangle correctly around its center" do
      corners = [
        Jazzicon::Point.new(x: 150, y: 150), # Top-left
        Jazzicon::Point.new(x: 250, y: 150), # Top-right
        Jazzicon::Point.new(x: 250, y: 250), # Bottom-right
        Jazzicon::Point.new(x: 150, y: 250)  # Bottom-left
      ]
      rotation = 90 # Rotate 90 degrees clockwise
      center = 200  # Center of the rectangle (x and y)

      rotated_corners = described_class.rotate_corners(corners, rotation, center)

      # Expected positions after 90-degree clockwise rotation around center (200, 200)
      expected_rotated_corners = [
        Jazzicon::Point.new(x: 250, y: 150), # Rotated Top-left
        Jazzicon::Point.new(x: 250, y: 250), # Rotated Top-right
        Jazzicon::Point.new(x: 150, y: 250), # Rotated Bottom-right
        Jazzicon::Point.new(x: 150, y: 150)  # Rotated Bottom-left
      ]

      rotated_corners.each_with_index do |(cx, cy), index|
        expect(cx).to be_within(0.01).of(expected_rotated_corners[index][0])
        expect(cy).to be_within(0.01).of(expected_rotated_corners[index][1])
      end
    end
  end
end
