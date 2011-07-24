class Level < ActiveRecord::Base
	def self.createFromJSON( level_json )
		create! do |level|
			level.title = level_json['editingInfo']['levelName']
			level.json = level_json.to_json
		end
	end

	def self.create_from_editor( title, level_json_string )
		create! do |level|
			level.title = title
			level.json = level_json_string
		end
	end
end
