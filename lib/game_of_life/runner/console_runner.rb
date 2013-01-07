module GameOfLife
  module Runner
    class ConsoleRunner < Base
      def initialize(grid, outputter = Outputter::FixedConsoleOutputter.new)
        add_int_trap
        super
      end

      def add_int_trap
        trap :INT do
          stop
        end
      end

      def stop
        system "clear"
        exit!
      end
    end
  end
end