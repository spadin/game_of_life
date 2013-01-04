require "game_of_life/grid"

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
  end
end