# frozen_string_literal: true

module Jazzicon
  HUE_WOBBLE = 30
  # The Jazzicon::ColorHelpers module provides color-related helper methods.
  module ColorHelpers
    # Shifts the hue of the given colors by a random amount.
    #
    # @param colors [Array<String>] Array of hex color strings.
    # @param random [Random] Random object for deterministic randomness.
    # @return [Array<String>] Array of hue-shifted colors.
    def self.hue_shift(colors, random)
      amount = (random.rand * 30) - (HUE_WOBBLE / 2.0)

      colors.map do |hex|
        hsl = ChunkyPNG::Color.to_hsl(ChunkyPNG::Color.from_hex(hex))
        hsl[0] = (hsl[0] + amount) % 360
        hsl[3] = 255
        ChunkyPNG::Color.from_hsl(*hsl)
      end
    end
  end
end
