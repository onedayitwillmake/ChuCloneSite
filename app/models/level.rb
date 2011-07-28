class Level < ActiveRecord::Base
	include LevelsHelper
	validate :must_be_logged_in
	validate :must_have_valid_level

	# TODO: REMOVE NEED FOR INSTANCE VARIABLE IN MODEL
	attr_accessor :current_user

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

	def must_have_valid_level
		# Check for valid json
		begin
			leveljson = ActiveSupport::JSON.decode(json)
		rescue Exception=>e
			errors.add(:json, "Invalid level data")
		end

		# Check for respawn
		unless has_component(leveljson, "RespawnComponent")
			errors.add(:json, "Must have at least 1 respawn point!")
		end

		# Check for player
		unless has_component(leveljson, "CharacterControllerComponent")
			errors.add(:json, "Must have a player character!")
		end

		# Check for goalpad
		unless has_component(leveljson, "GoalPadComponent")
			errors.add(:json, "Must have a GoalPad!")
		end
	end

	def must_be_logged_in
		if @current_user.nil? && self.current_user.nil? then
			errors.add("User", "Not logged in!")
		end
	end
end
