# |   **Bloco**    |                                        **Propósito**                                              |
# |----------------|---------------------------------------------------------------------------------------------------|
# |    describe    | Declara qual unidade de código está sendo testada (classe, método, funcionalidade).               |
# |    context     | Descreve um cenário específico ou condição em que os testes dentro dele serão executados.         |
# |       it       | Define um caso de teste individual, verificando um comportamento ou resultado esperado.           |
# |     expect     | Define a expectativa de um resultado específico, que será comparado com o valor retornado.        |

# Teste de modelo

require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { Game.new(game_state: Array.new(9, "")) }

  describe "validations" do
    it "is invalid without a game_state" do
      game.game_state = nil
      expect(game).not_to be_valid
    end
  end

  describe "#is_full?" do
    it "returns true when the board is full" do
    game.game_state = ["X", "O", "X", "X", "O", "O", "X", "O", "X"]
      expect(game.is_full?).to be true
    end

    it "returns false when the board is not full" do
      game.game_state = ["X", "O", "X", "", "O", "", "X", "O", "X"]
      expect(game.is_full?).to be false
    end
  end

  describe "#check_winner" do
    context "when a player wins by row" do
      it "updates the winner when the first row is filled by the same player" do
        game.game_state = ["X", "X", "X", "", "", "", "", "", ""]
        game.check_winner("X")
        expect(game.winner).to eq("X")
      end

      it "updates the winner when the second row is filled by the same player" do
        game.game_state = ["", "", "", "O", "O", "O", "", "", ""]
        game.check_winner("O")
        expect(game.winner).to eq("O")
      end
    end

    context "when a player wins by column" do
      it "updates the winner when the first column is filled by the same player" do
        game.game_state = ["X", "", "", "X", "", "", "X", "", ""]
        game.check_winner("X")
        expect(game.winner).to eq("X")
      end
    end

    context "when a player wins by diagonal" do
      it "updates the winner when the main diagonal is filled by the same player" do
        game.game_state = ["X", "", "", "", "X", "", "", "", "X"]
        game.check_winner("X")
        expect(game.winner).to eq("X")
      end

      it "updates the winner when the secondary diagonal is filled by the same player" do
        game.game_state = ["", "", "X", "", "X", "", "X", "", ""]
        game.check_winner("X")
        expect(game.winner).to eq("X")
      end
    end

    context "when the game is a draw" do
      it "updates the winner to 'draw' when the board is full and there is no winner" do
        game.game_state = ["X", "O", "X", "O", "X", "O", "O", "X", "O"]
        game.check_winner("X")
        expect(game.winner).to eq("draw")
      end
    end

    context "when there is no winner yet" do
      it "does not update the winner if there is no winning line or full board" do
        game.game_state = ["X", "O", "X", "", "", "", "", "", ""]
        game.check_winner("X")
        expect(game.winner).to eq("")
      end
    end
  end
end