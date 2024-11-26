class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|

      t.string :winner, default: ""
      t.string  :game_state, array: true, default: []

      t.timestamps
    end
  end
end
