# frozen_string_literal: true

module Jazzicon
  Rectangle = Struct.new(:corners, keyword_init: true)
  Point = Struct.new(:x, :y, keyword_init: true)
  Size = Struct.new(:width, :height, keyword_init: true)

  # The Jazzicon::GeometryHelpers module provides methods for geometric calculations and operations.
  module GeometryHelpers
    # Adds a randomly positioned and rotated rectangle to the given image.
    #
    # @param image [ChunkyPNG::Image] The image to modify.
    # @param diameter [Integer] The diameter of the image.
    # @param color [String] The color of the rectangle.
    # @param index [Integer] The index of the current shape.
    # @param total [Integer] The total number of shapes.
    # @param random_numbers [Array<Float>] Array of random numbers for positioning and rotation.
    def self.random_rectangle(diameter, index, total, random_numbers)
      velocity, rotation, angle = generate_momentum(diameter, index, total, random_numbers)
      center = diameter / 2.0

      point = Point.new(
        x: center + (Math.cos(angle) * velocity),
        y: center + (Math.sin(angle) * velocity)
      )
      size = Size.new(width: diameter, height: diameter)

      # Draw the rectangle
      rotated_rectangle(point, size, rotation, center)
    end

    private_class_method def self.generate_momentum(diameter, index, total, random_numbers)
      first_rot = random_numbers.pop
      velocity = (diameter / total * random_numbers.pop) + (index * diameter / total)
      rotation = (first_rot * 360) + (random_numbers.pop * 180)
      angle = Math::PI * 2 * first_rot

      [velocity, rotation, angle]
    end

    # Draws a rotated rectangle on the image.
    #
    # @param image [ChunkyPNG::Image] The image to modify.
    # @param x [Float] The x-coordinate of the rectangle's center.
    # @param y [Float] The y-coordinate of the rectangle's center.
    # @param width [Float] The width of the rectangle.
    # @param height [Float] The height of the rectangle.
    # @param color [String] The color of the rectangle.
    # @param rotation [Float] The rotation angle in degrees.
    # @param center [Float] The center point of the image.
    def self.rotated_rectangle(point, size, rotation, center)
      # Define the four corners of the rectangle
      corners = rotate_corners(calculate_corners(point, size), rotation, center)
      Rectangle.new(corners: corners)
    end

    # Calculates the four corners of a rectangle given its width and height.
    #
    # @param x [Float] The x-coordinate of the rectangle's center.
    # @param y [Float] The y-coordinate of the rectangle's center.
    # @param width [Float] The width of the rectangle.
    # @param height [Float] The height of the rectangle.
    # @return [Array<Array<Float>>] Array of coordinates representing the rectangle's corners.
    def self.calculate_corners(point, size)
      half_width = size.width / 2
      half_height = size.height / 2

      offsets = [
        [-half_width, -half_height], # Top-left
        [half_width, -half_height], # Top-right
        [half_width, half_height],  # Bottom-right
        [-half_width, half_height]  # Bottom-left
      ]

      offsets.map { |dx, dy| Point.new(x: point.x + dx, y: point.y + dy) }
    end

    # Rotates the given corners of a rectangle around its center.
    #
    # @param corners [Array<Array<Float>>] Array of rectangle corner coordinates.
    # @param rotation [Float] The rotation angle in degrees.
    # @param center [Float] The center point of the image.
    # @return [Array<Array<Float>>] Array of rotated corner coordinates.
    def self.rotate_corners(corners, rotation, center)
      rad_rotation = rotation * Math::PI / 180

      corners.map do |point|
        rotate_point(point, rad_rotation, center)
      end
    end

    private_class_method def self.rotate_point(point, rad_rotation, center)
      point.x -= center
      point.y -= center
      cos_theta = Math.cos(rad_rotation)
      sin_theta = Math.sin(rad_rotation)

      [
        (cos_theta * point.x) - (sin_theta * point.y) + center,
        (sin_theta * point.x) + (cos_theta * point.y) + center
      ]
    end
  end
end
