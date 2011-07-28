class GameController < ApplicationController
	def index
		@levels = Level.all(:order => "order_index")
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
