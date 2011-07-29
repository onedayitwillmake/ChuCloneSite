class CreateHighscores < ActiveRecord::Migration
  def self.up
    create_table :highscores do |t|
      t.float :score
      t.references :level
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :highscores
  end
end
