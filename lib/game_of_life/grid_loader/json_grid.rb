require 'json'

module GameOfLife
  module GridLoader
    class JsonGrid
      def self.load(filename)
        data = File.read(File.expand_path(filename))
        json_locations = JSON::parse(data)
        grid = Grid.new
        json_locations.each do |location|
          grid.bring_cell_to_life_at location
        end
        grid
      end
    end
  end
end
