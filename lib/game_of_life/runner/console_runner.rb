module GameOfLife
  module Runner
    class ConsoleRunner < Base
      def initialize(grid, outputter = FixedConsoleOutputter.new)
        # Unsure how to test this.
        Signal.trap :INT do
          system "clear"
          Kernel.exit!
        end

        super
      end
    end
  end
end