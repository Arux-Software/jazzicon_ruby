# frozen_string_literal: true

require "chunky_png"

require_relative "../lib/jazzicon"

namespace :icons do
  desc "Generate 20 icons and stitch them into a 4x5 grid"
  task :generate_example do
    # Settings
    icon_diameter, rows, columns = 500, 4, 5
    grid_width, grid_height = columns * icon_diameter, rows * icon_diameter

    # Create composite image
    composite_image = ChunkyPNG::Image.new(grid_width, grid_height, ChunkyPNG::Color::WHITE)

    # Generate and place icons
    (0...(rows * columns)).each do |i|
      icon = Jazzicon::Icon.generate("icon_#{i}", diameter: icon_diameter)
      x_offset, y_offset = (i % columns) * icon_diameter, (i / columns) * icon_diameter

      icon.pixels.each_with_index do |pixel, index|
        x, y = (index % icon.width) + x_offset, (index / icon.width) + y_offset
        composite_image[x, y] = pixel
      end
    end

    # Save the final stitched image
    composite_image.save("examples.png")
    puts "Generated and stitched icons saved to examples.png"
  end
end
