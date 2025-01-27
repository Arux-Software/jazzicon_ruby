# frozen_string_literal: true

require "chunky_png"

require_relative "../../lib/jazzicon/icon"

RSpec.describe Jazzicon::Icon do
  let(:seed) { "test-seed" }
  let(:diameter) { 100 }
  let(:shape_count) { 4 }

  describe ".generate" do
    it "generates a valid ChunkyPNG::Image object" do
      image = described_class.generate(seed, diameter: diameter, shape_count: shape_count)
      expect(image).to be_a(ChunkyPNG::Image)
    end

    it "creates an image with the specified diameter" do
      image = described_class.generate(seed, diameter: diameter, shape_count: shape_count)
      expect(image.width).to eq(diameter)
      expect(image.height).to eq(diameter)
    end

    it "generates the same image for the same seed" do
      image1 = described_class.generate(seed, diameter: diameter, shape_count: shape_count)
      image2 = described_class.generate(seed, diameter: diameter, shape_count: shape_count)
      expect(image1.pixels).to eq(image2.pixels)
    end

    it "generates a different image for a different seed" do
      image1 = described_class.generate(seed, diameter: diameter, shape_count: shape_count)
      image2 = described_class.generate("different-seed", diameter: diameter, shape_count: shape_count)
      expect(image1.pixels).not_to eq(image2.pixels)
    end
  end
end
