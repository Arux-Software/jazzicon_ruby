# frozen_string_literal: true

require_relative "../../lib/jazzicon/helpers/color_helpers"

RSpec.describe Jazzicon::ColorHelpers do
  describe ".hue_shift" do
    let(:colors) { ["#FF0000", "#00FF00", "#0000FF"] }
    let(:random) { Random.new(12_345) }

    it "returns an array of colors with adjusted hues" do
      shifted_colors = described_class.send(:hue_shift, colors, random)
      expect(shifted_colors.map { |s| ChunkyPNG::Color.to_hex(s) }).to all(match(/^#[A-Fa-f0-9]{8}$/))
      expect(shifted_colors.size).to eq(colors.size)
    end

    it "produces consistent output for the same random seed" do
      random1 = Random.new(12_345)
      random2 = Random.new(12_345)
      result1 = described_class.send(:hue_shift, colors, random1)
      result2 = described_class.send(:hue_shift, colors, random2)
      expect(result1).to eq(result2)
    end
  end
end
