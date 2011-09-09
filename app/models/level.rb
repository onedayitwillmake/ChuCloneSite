class Level < ActiveRecord::Base
	has_many :highscores
	belongs_to :user

	include LevelsHelper
#	validate :must_be_logged_in
	validate :must_have_valid_level

	# TODO: REMOVE NEED FOR INSTANCE VARIABLE IN MODEL
	attr_accessor :current_user

	##################
	# CLASS METHODS #
	################
	def self.createFromJSON(level_json)
		create! do |level|
			level.title = level_json['editingInfo']['levelName']
			level.json = level_json.to_json
		end
	end

	def self.create_from_editor(the_user, title, level_json_string)
		create! do |level|
			level.user = the_user
			level.title = title
			level.json = level_json_string.gsub(APP_CONFIG["SPECIAL_STRINGS"]["LEVEL_JSON"]["USER_NAME_MASK"], the_user.name)
# APP_CONFIG["DEFAULTS"]["MASTER_USER_ID"]
		end
	end

	def self.find_all_playable_levels
		Level.all(:select => 'title,id,user_id,times_played,times_completed', :conditions => ["playable = true"], :order => "order_index")
	end

	###############
	#   METHODS   #
	###############
	def increment_times_played
		self[:times_played] = self[:times_played] + 1
	end

	def increment_times_completed
		self[:times_completed] = self[:times_completed] + 1
	end

	def get_completion_rate
		self.times_played / self.times_completed
	end

	###############
	# VALIDATIONS #
	##############
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
