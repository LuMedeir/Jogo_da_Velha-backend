class Game < ApplicationRecord

  validates :game_state, presence: true

  def check_winner(player)

    if self.game_state[0] == player && self.game_state[1] == player && self.game_state[2] == player
      self.update(winner: player)
      return
    end

    if self.game_state[3] == player && self.game_state[4] == player && self.game_state[5] == player
      self.update(winner: player)
      return
    end

    if self.game_state[6] == player && self.game_state[7] == player && self.game_state[8] == player
      self.update(winner: player)
      return
    end

    if self.game_state[0] == player && self.game_state[3] == player && self.game_state[6] == player
      self.update(winner: player)
      return
    end

    if self.game_state[1] == player && self.game_state[4] == player && self.game_state[7] == player
      self.update(winner: player)
      return
    end

    if self.game_state[2] == player && self.game_state[5] == player && self.game_state[8] == player
      self.update(winner: player)
      return
    end

    if self.game_state[0] == player && self.game_state[4] == player && self.game_state[8] == player
      self.update(winner: player)
      return
    end
    
    if self.game_state[2] == player && self.game_state[4] == player && self.game_state[6] == player
      self.update(winner: player)
      return
    end

    if is_full?
      self.update(winner: "draw")
    end

  end

  def is_full?
    if self.game_state.all? { |cell| cell.present? }
      return true
    else
      return false
    end
  end
end
