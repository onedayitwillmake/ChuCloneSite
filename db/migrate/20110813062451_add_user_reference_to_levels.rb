class AddUserReferenceToLevels < ActiveRecord::Migration
  def self.up
	  change_table :levels do |t|
		  t.references :user
	  end
  end

  def self.down
	  change_table :levels do |t|
		  t.remove :user_id
	  end
  end
end
