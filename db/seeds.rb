# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Scrubs the level directory and adds those levels to the DB
def scrub_levels
	prefix = "#{APP_CONFIG["PATHS"]["LEVELS_DIRECTORY"]}/"
	Dir.glob(prefix + "*.json") do |rb_file|
		next if rb_file.include? '_t.json'

		file = File.open(rb_file, 'rb')
		contents = file.read

		#Overwrite author
		#mario gonzalez
		contents = contents.gsub(APP_CONFIG["SPECIAL_STRINGS"]["LEVEL_JSON"]["USER_NAME_MASK"], "1dayitwillmake")
		contents = contents.gsub("mario gonzalez", APP_CONFIG["SPECIAL_STRINGS"]["DEFAULTS"]["MASTER_USER_NAME"])

		# Write the file
		myStr = "This is a test"
		aFile = File.new(rb_file, "w")
		aFile.write(contents)
		aFile.close

		# Map to 1dayitwillmake
		user = User.find_by_name(APP_CONFIG["SPECIAL_STRINGS"]["DEFAULTS"]["MASTER_USER_NAME"])

		# Construct string into json object
		leveljson = ActiveSupport::JSON.decode(contents)
		levelname = leveljson["editingInfo"]["levelName"]


		# Check if exist
		#@level = Level.all# first('title' => levelname)
		@level = Level.find(:first, :conditions => ["title = :u", {:u => levelname}])



		if not @level.nil? then # Update
			puts "Found: #{@level.title.html_safe}...".html_safe



			# Save if record is different
			if not leveljson.to_json == @level.json then # Create new
				puts ">> Updated: " << @level.title
				@level.json = leveljson.to_json
				@level.user = user
				@level.save
			end
		else # Does not exist create it from the DB
			begin
				@new_level = Level.createFromJSON(leveljson)
				@new_level.user = user
				@new_level.save

				puts ">> Created:" << @new_level.title
			rescue Exception => e
				puts "FAILED: '#{levelname}':" << e.message
				#puts e.message
			end
		end
	end
end

scrub_levels