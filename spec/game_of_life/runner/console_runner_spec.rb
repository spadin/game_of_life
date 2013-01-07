require "spec_helper"

module GameOfLife
  module Runner
    describe ConsoleRunner do
      let(:outputter) { mock("outputter", :show_grid => nil) }
      let(:grid) { GameOfLife::GridLoader::JsonGrid.load("data/grid.json") }

      it "traps INT signal" do
        GameOfLife::Runner::ConsoleRunner.any_instance.should_receive(:trap).with(:INT)
        GameOfLife::Runner::ConsoleRunner.new(grid, outputter)
        
        lambda { raise Interrupt }
      end
    end
  end
end
