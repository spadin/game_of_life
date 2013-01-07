module GameOfLife
  module Runner
    class Base
      attr_accessor :outputter, :grid, :grid_advancer

      def initialize(grid, outputter)
        @grid, @outputter = grid, outputter
      end

      def start
        system "clear"
        outputter.show_grid grid
        until grid.empty?
          grid_advancer = GameOfLife::GridAdvancer.new(grid)
          self.grid = grid_advancer.grid_for_next_generation
          sleep(0.2)
          system "clear"
          outputter.show_grid grid
        end
      end
    end
  end
end