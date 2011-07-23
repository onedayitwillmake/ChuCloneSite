module ApplicationHelper
	def flash_helper

		f_names = [:notice, :warning, :message]
		fl = ''

		for name in f_names
			if flash[name]
				fl = fl + "<div class=\"notice\">#{flash[name]}</div>"
			end
			flash[name] = nil
		end
		return fl.html_safe()
	end

	def flash_helper_2
		output = ''

		flash.each do |name, msg|
			if msg.kind_of?(Array)
				msg.each do |contents|
					output << content_tag(:div, contents, :id => "flash_#{name}")
				end
			else
				output << content_tag(:div, msg, :id => "flash_#{name}")
			end

			return output.html_safe()
		end
	end

end
