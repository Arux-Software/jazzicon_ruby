# frozen_string_literal: true

require "chunky_png"
require "digest"

require_relative "helpers/color_helpers"
require_relative "helpers/geometry_helpers"
require_relative "helpers/image_helpers"

module Jazzicon
  COLORS = [
    "#01888C", "#FC7500", "#34E90B", "#FF4A4A",
    "#662E9B", "#FC7500", "#0284C7", "#A0D911",
    "#A855F7", "#FF7875"
  ].freeze
  Iteration = Struct.new(:index, :color, :random_numbers, keyword_init: true)

  # The Jazzicon::Icon class provides functionality to generate jazzy and colorful identicons.
  # These identicons are generated based on a given seed and can be customized by specifying the diameter and the number
  # of shapes that make up the icon.
  #
  # The main steps involved in generating an icon include:
  # - Hashing the seed to ensure deterministic randomness.
  # - Randomly selecting and hue-shifting colors.
  # - Generating and combining multiple layers of shapes (rectangles) to create a visually distinctive pattern.
  # - Cropping the image into a circular form.
  #
  # Key Features:
  # - Deterministic: The same seed always produces the same icon.
  # - Customizable: Supports customization of diameter and shape count.
  #
  # Dependencies:
  # - `chunky_png`: Used for image creation and manipulation.
  #
  # Example Usage:
  # ```
  # require "jazzicon/icon"
  #
  # seed = "example-seed"
  # diameter = 500
  # shape_count = 4
  #
  # icon = Jazzicon::Icon.generate(seed, diameter: diameter, shape_count: shape_count)
  # icon.save("icon.png")
  # ```
  class Icon
    # Generates a unique icon based on the given seed.
    #
    # @param seed [String, Integer] The input seed used to generate the icon.
    # @param diameter [Integer] The diameter of the generated icon.
    # @param shape_count [Integer] The number of shapes to include in the icon.
    # @return [ChunkyPNG::Image] The generated icon image.
    def self.generate(seed, diameter: 500, shape_count: 4)
      random = random(seed)
      colors = ColorHelpers.hue_shift(COLORS.shuffle(random: random), random)

      final_image = ChunkyPNG::Image.new(diameter, diameter, colors.delete(colors.sample(random: random)))

      # Generate each shape and adds it
      iterations(shape_count, colors, random).each do |iteration|
        rec = GeometryHelpers.random_rectangle(diameter, iteration.index, shape_count, iteration.random_numbers)
        final_image.polygon(rec.corners, iteration.color, iteration.color)
      end

      # Crop to a perfect circle
      ImageHelpers.crop_to_circle(final_image, diameter)

      # Profit!$!
      final_image
    end

    private_class_method def self.random(seed)
      # Hash the seed if it is a string
      seed = Digest::SHA256.hexdigest(seed).to_i(16) if seed.is_a?(String)
      Random.new(seed)
    end

    private_class_method def self.iterations(shape_count, colors, random)
      (0...shape_count).map do |i|
        Iteration.new(
          index: i,
          color: colors.delete(colors.sample(random: random)),
          random_numbers: 3.times.map { random.rand }
        )
      end
    end
  end
end
