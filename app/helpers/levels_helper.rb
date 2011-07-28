module LevelsHelper
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
