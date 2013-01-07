module GameOfLife
  class GridAdvancer
    attr_accessor :grid

    def initialize(grid)
      @grid = grid
    end

    def grid_for_next_generation
      next_grid = Grid.new
      grid.potentially_living_cells.each do |potential_location|
        if should_be_alive_in_next_generation?(potential_location)
          next_grid.bring_cell_to_life_at(potential_location)
        end
      end
      next_grid
    end

    private

    def should_be_alive_in_next_generation?(location)
      number_of_living_neighbors = grid.number_of_living_neighbors_for(location)
      return true if number_of_living_neighbors == 3
      return grid.has_living_cell_at?(location) if number_of_living_neighbors == 2
    end

  end
end