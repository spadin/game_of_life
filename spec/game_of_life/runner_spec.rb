require "game_of_life/runner"

module GameOfLife
  describe Runner do
    let(:outputter) { mock("outputter") }
    let(:empty_grid) { mock("grid", empty?: true) }

    before do
      Runner.any_instance.stub(:system)
    end

    it "outputs the grid" do
      runner = Runner.new(empty_grid, outputter)

      outputter.should_receive(:show_grid).with(empty_grid).exactly(1).times
      runner.start
    end

    it "shows the grid twice" do
      grid = mock("original grid", empty?: false, grid_for_next_generation: empty_grid)
      runner = Runner.new(grid, outputter)
      runner.stub(:sleep)
      
      outputter.should_receive(:show_grid).with(grid).exactly(1).times
      outputter.should_receive(:show_grid).with(empty_grid).exactly(1).times
      runner.start
    end
  end
end