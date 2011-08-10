class AlterJsonInLevels < ActiveRecord::Migration
  def self.up
	  change_column :levels, :json, :text, :limit => 16777215
  end

  def self.down
	  change_column :levels, :json, :text, :limit => 65535
  end
end
