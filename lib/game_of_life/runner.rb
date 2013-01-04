module GameOfLife
  class Runner
    attr_accessor :outputter, :grid

    def initialize(grid, outputter)
      @grid, @outputter = grid, outputter
    end

    def start
      system "clear"
      outputter.show_grid grid
      until grid.empty?
        self.grid = grid.grid_for_next_generation
        sleep(0.2)
        system "clear"
        outputter.show_grid grid
      end
    end
  end
end