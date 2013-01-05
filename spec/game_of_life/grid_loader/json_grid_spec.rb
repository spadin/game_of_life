require "spec_helper"

module GameOfLife
  module GridLoader
    describe JsonGrid do
      let(:grid) { JsonGrid.load("data/grid.json") }

      it "creates a grid" do
        grid.class.should be Grid
      end

      it "loads a grid with 5 living cell" do
        grid.has_living_cell_at?([0,2]).should be_true
        grid.has_living_cell_at?([1,3]).should be_true
        grid.has_living_cell_at?([2,1]).should be_true
        grid.has_living_cell_at?([2,2]).should be_true
        grid.has_living_cell_at?([2,3]).should be_true
      end
    end
  end
end