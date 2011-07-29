class GameController < ApplicationController
	def index
		@levels = Level.all(:order => "order_index")
		# Load the title screen by default
		@level = Level.find_all_by_title( APP_CONFIG["DEFAULTS"]["TITLE_SCREEN_LEVEL"] ).first
	end

	def edit
		if not params[:id].nil?
			@level = Level.find(params[:id])
		end
	end

	def show
		if not params[:id].nil?
			@level = Level.find(params[:id])
			@levels = Level.all(:order => "order_index")
			render :template => "game/index"
		end
	end
end
