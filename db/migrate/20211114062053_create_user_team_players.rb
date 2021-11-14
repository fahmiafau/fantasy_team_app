class CreateUserTeamPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_team_players do |t|
      t.references :player, null: false, foreign_key: true
      t.references :user_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
