module GameOfLife
  class Grid
    
    attr_accessor :live_locations

    def initialize
      self.live_locations = Set.new
    end
    
    def bring_cell_to_life_at(location)
      live_locations.add location
    end

    def kill_cell_at(location)
      live_locations.delete location
    end

    def has_living_cell_at?(location)
      live_locations.include? location
    end

    def number_of_living_neighbors_for(location)
      neighbors_of(location).inject(0) do |number_of_living_neighbors, neighbor|
        number_of_living_neighbors += 1 if live_locations.include? neighbor
        number_of_living_neighbors
      end
    end

    def potentially_living_cells
      live_locations.inject(Set.new) do |potential_cells, live_cell|
        potential_cells.merge [live_cell] + neighbors_of(live_cell)
      end
    end

    private

    def neighbors_of(location)
      [-1, 0, 1].product([-1, 0, 1]).collect do |location_offset|
        [location_offset.first+location.first, location_offset.last+location.last] unless location_offset == [0, 0]
      end.compact
    end
  end
end
