class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.bigint :team_id
      t.decimal :price
      t.boolean :is_constructor

      t.timestamps
    end
  end
end
