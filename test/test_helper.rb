ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class GameTest < ActiveSupport::TestCase
  test "should not save game without game_state" do
    game = Game.new
    assert_not game.save, "Saved the game without a game_state"
  end

  test "should detect full game state" do
    game = Game.new(game_state: ["X", "O", "X", "O", "X", "O", "X", "O", "X"])
    assert game.is_full?, "Game state should be full"
  end

  test "should detect winner in first row" do
    game = Game.new(game_state: ["X", "X", "X", "O", "", "O", "", "", ""])
    game.check_winner("X")
    assert_equal "X", game.winner, "Winner should be X"
  end

  test "should detect winner in second column" do
    game = Game.new(game_state: ["X", "O", "X", "X", "O", "O", "X", "", ""])
    game.check_winner("X")
    assert_equal "X", game.winner, "Winner should be X"
  end

  test "should detect winner in desc diagonal" do
    game = Game.new(game_state: ["X", "O", "O", "O", "X", "O", "O", "O", "X"])
    game.check_winner("X")
    assert_equal "X", game.winner, "Winner should be X"
  end

  test "should detect winner in crescent diagonal" do
    game = Game.new(game_state: ["X", "O", "O", "", "O", "", "O", "X", "X"])
    game.check_winner("O")
    assert_equal "O", game.winner, "Winner should be O"
  end
end
