class LevelsController < ApplicationController
	protect_from_forgery :except => :create_from_editor

	# GET /levels
	# GET /levels.xml
	def index
		redirect_to(root_url) and return if current_user.nil?

		@levels = current_user.levels.all(:order => 'order_index DESC')

		#
		#@levels = Level.find(:all, :order => 'order_index')

		respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @levels }
		end
	end

	# GET /levels/reorder
	def reorder
		redirect_to(root_url) and return if current_user.nil?

		if defined?(params[:type]) && params[:type] == "save" then
			flash[:notice] = params[:type]
		end

		@levels = current_user.levels.find_all_playable_levels
		respond_to do |format|
			format.html # reoder.html.erb
			format.js { render :json => @levels }
		end
	end

	# GET /levels/reorder/save
	def save_order
		sortinfo = ActiveSupport::JSON.decode(params[:data])
		sendback = []

		sortinfo.each do | leveldata |
			@level = Level.find( leveldata["id"], :select => 'id' )
			@level.order_index = leveldata["order_index"]
			@level.save(:validate => false)
		end

		render :json => sendback
	end

	# GET /levels/1
	# GET /levels/1.xml
	def show

		@level = Level.find(params[:id])
		@level.increment_times_played

		respond_to do |format|
			format.html # show.html.erb
			format.js {
				# Make a key for the user to be able to submit a score once they're done
				unless current_user.nil?
					key = EzCrypto::Key.with_password(APP_CONFIG["SECRET"]["TOKEN"], params[:id], :algorithm => 'blowfish')
					current_user.ScoreHash = key.encrypt64(Time.now.to_i.to_s)
					current_user.save
				end
				render :json => @level.json
			}
		end
	end

	# Ruturns only the json level data
	# GET /levels/data.json
	# get /levels/data/1.json
	def data
		@levels = (params[:id].nil?) ? Level.all(:select => 'title,id', :order => 'order_index') : Level.find(params[:id], :select => 'title,id')
		respond_to do |format|
			format.xml { render :xml => @levels }
			format.json { render :json => @levels }
		end
	end


	## GET /levels/new
	## GET /levels/new.xml
	#def new
	#	redirect_to root_url and return
	#end

	# GET /levels/1/edit
	#def edit
	#	@level = Level.find(params[:id])
	#	redirect_to(root_url) and return if current_user.nil? || @level.user.id != current_user.id
	#end

	# POST /levels
	# POST /levels.xml
	def create
		@level = Level.new(params[:level])

		respond_to do |format|
			if @level.save
				format.html { redirect_to(@level, :notice => 'Level was successfully created.') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	# Save a level from the editor via POST
	# POST /levels/create_from_editor
	def create_from_editor
		render(:json => ["status" => false, "notice" => [ ["Not signed in"] ]]) and return if current_user.nil?

		# Overwriting level?
		@level = Level.find_by_title(params[:levelName])

		# Create or update
		if @level.nil?
			Level.create_from_editor(current_user, params[:levelName], params[:level_json])
		else
			render(:json => ["status" => false, "notice" => [["Cannot save over another users level"]] ]) and return if @level.user.id != current_user.id

			@level.current_user = current_user
			@level.playable = false if current_user.name != APP_CONFIG["DEFAULTS"]["MASTER_USER_NAME"]
			@level.json = params[:level_json]
			unless @level.save
				render(:json => ["notice" => @level.errors, "status" => false])
				return
			end
		end

		if(current_user.name != APP_CONFIG["DEFAULTS"]["MASTER_USER_NAME"])
			dir = "#{APP_CONFIG["PATHS"]["LEVELS_DIRECTORY"]}/_users/#{current_user.name}"
		else
			dir = "#{APP_CONFIG["PATHS"]["LEVELS_DIRECTORY"]}"
		end

		# Save level to file with same name
		FileUtils.mkdir_p "#{dir}"

		file = File.new("#{dir}/#{params[:levelName]}.json", "w")
		file.write(params[:level_json])
		file.close

		# Spit back info
		render(:json => ["status" => true, "notice" => @level])
	end

	## PUT /levels/1
	## PUT /levels/1.xml
	#def update
	#	@level = Level.find(params[:id])
	#	redirect_to(root_url) and return if current_user.nil? || @level.user.id != current_user.id
	#
	#	respond_to do |format|
	#		if @level.update_attributes(params[:level])
	#			format.html { redirect_to(@level, :notice => 'Level was successfully updated.') }
	#			format.xml { head :ok }
	#		else
	#			format.html { render :action => "edit" }
	#			format.xml { render :xml => @level.errors, :status => :unprocessable_entity }
	#		end
	#	end
	#end

	# DELETE /levels/1
	# DELETE /levels/1.xml
	#def destroy
	#	@level = Level.find(params[:id])
	#	redirect_to(root_url) and return if current_user.nil? || @level.user.id != current_user.id
	#	puts @level.user.id
	#	#puts current_user.id
	#	format.html { redirect_to(levels_url) }
	#	return
	#	#redirect_to(root_url) and return if current_user.nil? || @level.user.id != current_user.id
	#
	#	@level.destroy
	#
	#	respond_to do |format|
	#		format.html { redirect_to(levels_url) }
	#		format.xml { head :ok }
	#	end
	#end
end
