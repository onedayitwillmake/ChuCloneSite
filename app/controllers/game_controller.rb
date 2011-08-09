class GameController < ApplicationController
	def index
		@levels = Level.find_all_playable_levels
		# Load the title screen by default
		@level = Level.find_all_by_title( APP_CONFIG["DEFAULTS"]["TITLE_SCREEN_LEVEL"] ).first
  end

  def pure
		@levels = Level.find_all_playable_levels
		# Load the title screen by default
		@level = Level.find_all_by_title( APP_CONFIG["DEFAULTS"]["TITLE_SCREEN_LEVEL"] ).first
  end

  def remoteplay
		@levels = Level.find_all_playable_levels
		# Load the title screen by default
		@level = Level.find_all_by_title( APP_CONFIG["DEFAULTS"]["TITLE_SCREEN_LEVEL"] ).first
  end

	def edit
    # kill if nil
    redirect_to(:action => "index") and return if current_user.nil?

    if not params[:id].nil?
			@level = Level.find(params[:id])
		end
	end

	def show
		if not params[:id].nil?
			@level = Level.find(params[:id])
			@levels = Level.find_all_playable_levels
			render :template => "game/index"
		end
	end
end
