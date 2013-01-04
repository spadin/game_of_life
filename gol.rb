$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

require "game_of_life/grid"
require "game_of_life/runner"
require "game_of_life/fixed_console_outputter"

grid = GameOfLife::Grid.new
grid.bring_cell_to_life_at([0,2])
grid.bring_cell_to_life_at([1,3])
grid.bring_cell_to_life_at([2,1])
grid.bring_cell_to_life_at([2,2])
grid.bring_cell_to_life_at([2,3])

GameOfLife::Runner.new(grid, GameOfLife::FixedConsoleOutputter.new(STDOUT)).start