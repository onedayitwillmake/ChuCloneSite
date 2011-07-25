class LevelsController < ApplicationController
	protect_from_forgery :except => :create_from_editor

	# GET /levels
	# GET /levels.xml
	def index

		@levels = Level.all


#		n = SessionsController.new
		respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @levels }
		end
	end

	# GET /levels/scrub
	def scrub
		flash[:notice] = []
		prefix = 'public/game/assets/levels/'
		Dir.glob(prefix + "*.json" ) do |rb_file|
			next if rb_file.include? '_t.json'

			file = File.open(rb_file, 'rb')
			contents = file.read

			leveljson = ActiveSupport::JSON.decode(contents)
			levelname = leveljson["editingInfo"]["levelName"]

			@level = Level.first('title' => levelname)

##		  Alternative way of searching for file in DB - returns only the first
##		  @level = Level.find(:first, :conditions => ["title = :u", {:u => levelName}]);

			if not @level.nil? then
				flash[:notice] << ("Updated: " << @level.title.html_safe)

				# Save if record is different
				if not leveljson.to_json == @level.json then
					@level.json = leveljson.to_json
					@level.save
				end
			else # Does not exist create it from the DB
				flash[:notice] << ("Created: " << Level.createFromJSON(leveljson).inspect)
			end
		end
	end

	# GET /levels/reorder
	def reorder

		if defined?(params[:type]) && params[:type] == "save" then
			flash[:notice] = params[:type]
		end

		@levels = Level.all
		respond_to do |format|
			format.html # reoder.html.erb
			format.js { render :json => @levels }
		end
	end

	# GET /levels/reorder/save
	def save_order
		sortinfo = ActiveSupport::JSON.decode(params[:data])
		sendback = []

		sortinfo.each do |leveldata|
			level = Level.find( leveldata["id"] )
			level.order_index = leveldata["order_index"]
			level.save
		end

#		@levels = Level.all
		render :json => sendback
	end

	# GET /levels/1
	# GET /levels/1.xml
	def show
		@level = Level.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml { render :xml => @level }
			format.js { render :json => @level.json }
		end
	end

	# Ruturns only the json level data
	# GET /levels/data.json
	# get /levels/data/1.json
	def data
		@levels = (params[:id].nil?) ? Level.all(:select => 'title,id') : Level.find(params[:id], :select => 'title,id')

		respond_to do |format|
			format.xml { render :xml => @levels }
			format.json { render :json => @levels }
		end
	end


	# GET /levels/new
	# GET /levels/new.xml
	def new
		@level = Level.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml { render :xml => @level }
		end
	end

	# GET /levels/1/edit
	def edit
		@level = Level.find(params[:id])
	end

	# POST /levels
	# POST /levels.xml
	def create
		@level = Level.new(params[:level])

		respond_to do |format|
			if @level.save
				format.html { redirect_to(@level, :notice => 'Level was successfully created.') }
				format.xml { render :xml => @level, :status => :created, :location => @level }
			else
				format.html { render :action => "new" }
				format.xml { render :xml => @level.errors, :status => :unprocessable_entity }
			end
		end
	end

	# Save a level from the editor via POST
	# POST /levels/create_from_editor
	def create_from_editor
		# Kill if user is nill
		render(:json => ["status" => false, "notice" => "Not logged in"]) if current_user.nil?

		# Overwriting level?
		@level = Level.find_by_title(params[:levelName])

		# Create or update
		if @level.nil?
			Level.create_from_editor(params[:levelName], params[:level_json])
		else
			@level.json = params[:data]
		end

		# Spit back info
		render(:json => ["status" => true, "notice" => @level])
	end

	# PUT /levels/1
	# PUT /levels/1.xml
	def update
		@level = Level.find(params[:id])

		respond_to do |format|
			if @level.update_attributes(params[:level])
				format.html { redirect_to(@level, :notice => 'Level was successfully updated.') }
				format.xml { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml { render :xml => @level.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /levels/1
	# DELETE /levels/1.xml
	def destroy
		@level = Level.find(params[:id])
		@level.destroy

		respond_to do |format|
			format.html { redirect_to(levels_url) }
			format.xml { head :ok }
		end
	end
end
