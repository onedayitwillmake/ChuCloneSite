class Level < ActiveRecord::Base
	def self.createFromJSON( levelJSON )
		create! do |level|
			level.title = levelJSON['editingInfo']['levelName']
			level.json = levelJSON.to_json
		end
	end
end
