
class AddPlayableToLevels < ActiveRecord::Migration
  def self.up
    add_column :levels, :playable, :boolean, { :default => true }
  end

  def self.down
    remove_column :levels, :playable
  end
end
