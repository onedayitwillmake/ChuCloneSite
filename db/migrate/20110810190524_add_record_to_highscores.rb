class AddRecordToHighscores < ActiveRecord::Migration
  def self.up
    add_column :highscores, :playerRecord, :text
  end

  def self.down
    remove_column :highscores, :playerRecord
  end
end
