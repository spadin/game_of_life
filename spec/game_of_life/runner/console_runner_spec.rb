require "spec_helper"

module GameOfLife
  module Runner
    describe ConsoleRunner do
      let(:outputter) { mock("outputter", :show_grid => nil) }

      it "traps INT signal" do
        GameOfLife::Runner::ConsoleRunner.any_instance.should_receive(:trap).with(:INT)
        grid = GameOfLife::GridLoader::JsonGrid.load("data/grid.json")
        runner = GameOfLife::Runner::ConsoleRunner.new(grid, outputter)
        blk = lambda { raise Interrupt }
      end
    end
  end
end
