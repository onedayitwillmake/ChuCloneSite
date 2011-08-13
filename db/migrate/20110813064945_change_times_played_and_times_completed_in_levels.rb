class ChangeTimesPlayedAndTimesCompletedInLevels < ActiveRecord::Migration
	def self.up
		change_column_default(:levels, :times_played, 0)
		change_column_default(:levels, :times_completed, 0)
	end

	def self.down
		change_column_default(:levels, :times_played, nil)
		change_column_default(:levels, :times_completed, nil)
	end
end
