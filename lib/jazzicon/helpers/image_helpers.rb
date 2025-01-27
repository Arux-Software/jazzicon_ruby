# frozen_string_literal: true

require "chunky_png"

module Jazzicon
  # The Jazzicon::ImageHelpers module provides methods for adjusting the whole image.
  module ImageHelpers
    # Crops the image to a perfect circle.
    #
    # @param image [ChunkyPNG::Image] The image to crop.
    # @param diameter [Integer] The diameter of the circle.
    def self.crop_to_circle(image, diameter)
      center = diameter / 2.0
      radius = diameter / 2.0

      image.height.times do |y|
        image.width.times do |x|
          # Check if the pixel is outside the circle
          outside = (((x - center)**2) + ((y - center)**2)) > radius**2
          image.set_pixel(x, y, ChunkyPNG::Color::TRANSPARENT) if outside
        end
      end
    end
  end
end
