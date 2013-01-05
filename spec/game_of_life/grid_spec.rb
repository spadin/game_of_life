require "spec_helper"

module GameOfLife
  describe Grid do
    let(:grid) {Grid.new}

    it "starts with a non-living cell" do
      grid.should_not have_living_cell_at([123, 456])
    end

    it "brings a cell to life" do
      grid.bring_cell_to_life_at([123, 456])
      grid.should have_living_cell_at([123, 456])
    end

    it "kills a cell" do
      location = [1,5]
      grid.bring_cell_to_life_at(location)
      grid.kill_cell_at(location)
      grid.should_not have_living_cell_at(location)
    end

    it "starts empty" do
      grid.should be_empty
    end

    it "is not empty with a living cell" do
      grid.bring_cell_to_life_at([123, 456])
      grid.should_not be_empty
    end

    context "#number_of_living_neighbors_for" do
      it "has no living neighbors" do
        grid.bring_cell_to_life_at([1,1])
        grid.number_of_living_neighbors_for([1,1]).should == 0
      end

      it "has one living neighbor" do
        grid.bring_cell_to_life_at([1,1])
        grid.bring_cell_to_life_at([1,2])
        grid.number_of_living_neighbors_for([1,1]).should == 1
      end

      it "has two living neighbors" do
        grid.bring_cell_to_life_at([1,1])
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([1,2])
        grid.number_of_living_neighbors_for([1,1]).should == 2
      end

      it "is surrounded by living neighbors" do
        3.times do |row|
          3.times do |col|
            grid.bring_cell_to_life_at([row, col])
          end
        end
        
        grid.number_of_living_neighbors_for([1,1]).should == 8
      end
    end

    context "potentially alive in the next generation" do
      it "starts with none" do
        grid.potentially_living_cells.should be_empty
      end

      it "includes living cells" do
        grid.bring_cell_to_life_at([123,456])
        grid.potentially_living_cells.should include([123,456])
      end

      it "includes living cell and its neighbors" do
        grid.bring_cell_to_life_at([123,456])
        grid.potentially_living_cells.size.should == 9
      end

      it "works with two far away living cells" do
        grid.bring_cell_to_life_at([1,1])
        grid.bring_cell_to_life_at([5,5])
        grid.potentially_living_cells.size.should == 18
      end

      it "works with two adjacent living cells" do
        grid.bring_cell_to_life_at([1,1])
        grid.bring_cell_to_life_at([1,2])
        grid.potentially_living_cells.size.should == 12
      end
    end

    context "determining the next generation of the grid" do
      it "kills a cell with no living neighbors" do
        grid.bring_cell_to_life_at([1,1])
        next_grid = grid.grid_for_next_generation
        next_grid.should_not have_living_cell_at([1,1])
      end

      it "keeps a cell alive with 2 living neighbors" do
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([0,1])
        grid.bring_cell_to_life_at([0,2])
        next_grid = grid.grid_for_next_generation
        next_grid.should have_living_cell_at([0,1])
      end

      it "keeps a cell alive with 3 living neighbors" do
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([0,1])
        grid.bring_cell_to_life_at([0,2])
        grid.bring_cell_to_life_at([1,2])
        next_grid = grid.grid_for_next_generation
        next_grid.should have_living_cell_at([0,1])
      end

      it "brings a dead cell with 3 living neighbors to life" do
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([0,1])
        grid.bring_cell_to_life_at([0,2])
        next_grid = grid.grid_for_next_generation
        next_grid.should have_living_cell_at([1,1])
      end

      it "keeps a dead cell with 2 living neighbors dead" do
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([0,1])
        next_grid = grid.grid_for_next_generation
        next_grid.should_not have_living_cell_at([1,1])
      end
    end
  end
end