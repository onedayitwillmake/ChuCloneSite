class AddScoreHashToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :ScoreHash, :string
  end

  def self.down
    remove_column :users, :ScoreHash
  end
end
