# frozen_string_literal: true

require "chunky_png"

require_relative "../../lib/jazzicon/helpers/image_helpers"

RSpec.describe Jazzicon::ImageHelpers do
  let(:diameter) { 100 }

  describe ".crop_to_circle" do
    let(:png) { ChunkyPNG::Image.new(diameter, diameter, ChunkyPNG::Color::WHITE) }

    it "removes pixels outside the circular area" do
      described_class.send(:crop_to_circle, png, diameter)
      center = diameter / 2.0
      radius = diameter / 2.0
      png.height.times do |y|
        png.width.times do |x|
          distance = Math.sqrt(((x - center)**2) + ((y - center)**2))
          if distance > radius
            expect(png[x, y]).to eq(ChunkyPNG::Color::TRANSPARENT)
          else
            expect(png[x, y]).not_to eq(ChunkyPNG::Color::TRANSPARENT)
          end
        end
      end
    end
  end
end
