require "spec_helper"
require "stringio"

module GameOfLife
  module Outputter
    describe FixedConsoleOutputter do
      it "outputs the grid" do
        grid = Grid.new
        grid.bring_cell_to_life_at([0,0])
        grid.bring_cell_to_life_at([0,1])
        grid.bring_cell_to_life_at([0,2])
        grid.bring_cell_to_life_at([9,9])
        output = StringIO.new
        outputter = FixedConsoleOutputter.new(output)
        outputter.show_grid(grid)

        expected_output = <<END
XXX-------
----------
----------
----------
----------
----------
----------
----------
----------
---------X
END
        output.string.strip.should == expected_output.strip
      end
    end
  end
end