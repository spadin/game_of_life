require "spec_helper"

module GameOfLife
  describe GridAdvancer do
    let(:grid) { Grid.new }
    let(:grid_advancer) { GridAdvancer.new(grid) }

    it "kills a cell with no living neighbors" do
      grid.bring_cell_to_life_at([1,1])
      next_grid = grid_advancer.grid_for_next_generation
      next_grid.should_not have_living_cell_at([1,1])
    end

    it "keeps a cell alive with 2 living neighbors" do
      grid.bring_cell_to_life_at([0,0])
      grid.bring_cell_to_life_at([0,1])
      grid.bring_cell_to_life_at([0,2])
      next_grid = grid_advancer.grid_for_next_generation
      next_grid.should have_living_cell_at([0,1])
    end

    it "keeps a cell alive with 3 living neighbors" do
      grid.bring_cell_to_life_at([0,0])
      grid.bring_cell_to_life_at([0,1])
      grid.bring_cell_to_life_at([0,2])
      grid.bring_cell_to_life_at([1,2])
      next_grid = grid_advancer.grid_for_next_generation
      next_grid.should have_living_cell_at([0,1])
    end

    it "brings a dead cell with 3 living neighbors to life" do
      grid.bring_cell_to_life_at([0,0])
      grid.bring_cell_to_life_at([0,1])
      grid.bring_cell_to_life_at([0,2])
      next_grid = grid_advancer.grid_for_next_generation
      next_grid.should have_living_cell_at([1,1])
    end

    it "keeps a dead cell with 2 living neighbors dead" do
      grid.bring_cell_to_life_at([0,0])
      grid.bring_cell_to_life_at([0,1])
      next_grid = grid_advancer.grid_for_next_generation
      next_grid.should_not have_living_cell_at([1,1])
    end
  end
end