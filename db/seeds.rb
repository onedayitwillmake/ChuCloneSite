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

    leveljson = ActiveSupport::JSON.decode(contents)
    levelname = leveljson["editingInfo"]["levelName"]


    # Check if exist
    #@level = Level.all# first('title' => levelname)
    @level = Level.find(:first, :conditions => ["title = :u", {:u => levelname}])


    #raise @level.to_yaml
    #		  Alternative way of searching for file in DB - returns only the first
    ##		  @level = Level.find(:first, :conditions => ["title = :u", {:u => levelName}]);

    #puts @level.to_yaml
    if not @level.nil? then # Update
      #puts @level.to_yaml
      puts "Found: #{@level.title.html_safe}...".html_safe
      
      # Save if record is different
      if not leveljson.to_json == @level.json then # Create new
        puts "Updated: " << @level.title
        @level.json = leveljson.to_json
        @level.save
      end
    else # Does not exist create it from the DB
      begin
        @newLevel = Level.createFromJSON(leveljson)
        puts "Created:" << @newLevel.title
      rescue Exception => e
        puts "FAILED: '#{levelname}':" << e.message
        #puts e.message
      end
    end
  end
end

scrub_levels