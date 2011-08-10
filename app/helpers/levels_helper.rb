module LevelsHelper

	# Checks to see if there is a current user for this session
	def get_current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	# Checks the json for a component type by name
	def has_component leveljson, component_name
		found_component = false
		leveljson["bodyList"].each do |item|
			item["components"].each do |component|
				if component["displayName"] == component_name then
					found_component = true
				end
			end
		end
		found_component
	end
end
