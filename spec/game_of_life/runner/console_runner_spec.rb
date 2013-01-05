require "game_of_life/runner/console_runner"

module GameOfLife
  module Runner
    describe ConsoleRunner do
      let(:outputter) { mock("outputter", :show_grid => nil) }

      xit "shuts down on SIGINT" do
        grid = GameOfLife::GridLoader::JsonGrid.load("data/grid.json")
        pid = Process.fork do
          GameOfLife::Runner::ConsoleRunner.new(grid, outputter).start
        end
        Process.kill(:INT, pid)
      end
    end
  end
end
