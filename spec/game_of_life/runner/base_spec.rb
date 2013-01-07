require "spec_helper"

module GameOfLife
  module Runner
    describe Runner::Base do
      let(:outputter) { mock("outputter") }
      let(:empty_grid) { mock("grid", empty?: true) }

      before do
        Base.any_instance.stub(:system)
      end

      it "outputs the grid" do
        runner = Runner::Base.new(empty_grid, outputter)

        outputter.should_receive(:show_grid).with(empty_grid).exactly(1).times
        runner.start
      end

      it "shows the grid twice" do
        GridAdvancer.any_instance.stub(:grid_for_next_generation).and_return(empty_grid)
        grid = mock("original grid", empty?: false)
        runner = Runner::Base.new(grid, outputter)
        runner.stub(:sleep)
        
        outputter.should_receive(:show_grid).with(grid).exactly(1).times
        outputter.should_receive(:show_grid).with(empty_grid).exactly(1).times
        runner.start
      end
    end
  end
end