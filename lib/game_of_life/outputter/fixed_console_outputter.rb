module GameOfLife
  module Outputter
    class FixedConsoleOutputter
      attr_accessor :output

      def initialize(output = STDOUT)
        @output = output
      end

      def show_grid(grid)
        10.times do |row|
          10.times do |col|
            if grid.has_living_cell_at?([row, col])
              output.print "X"
            else
              output.print "-"
            end
          end
          output.print "\n"
        end
      end
    end
  end
end