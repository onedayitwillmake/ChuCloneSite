class AddBetaToLevels < ActiveRecord::Migration
  def self.up
    add_column :levels, :is_beta, :boolean, :default => false
  end

  def self.down
    remove_column :levels, :is_beta
  end
end
