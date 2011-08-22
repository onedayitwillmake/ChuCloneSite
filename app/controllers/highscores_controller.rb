require 'ezcrypto'
class HighscoresController < ApplicationController
	protect_from_forgery :except => :create

	def index
		if not params[:level_id].nil?
			@level = Level.find(params[:level_id])
			@levels = Level.find_all_playable_levels

			#render :xml => @level.highscores.to_xml
			render :template => "highscores/score_index_ajax" and return
			render :template => "game/score_index" and return if @_request.method == "GET"


		end
	end

	# Creates a Highscore entry for this level by current_user
	# POST /levels/:id/highscores.json
	def create
		render(:json => ["notice" => "Not signed in", "status" => false]) and return unless current_user
		render(:json => ["notice" => "Error 504", "status" => false]) and return unless current_user.ScoreHash != ""

		score_hash = current_user.ScoreHash

		# Remove the hash from the user so they can't resubmit for this level
		current_user.update_attribute(:ScoreHash, "")

		score = params[:score].to_i
		recording = ActiveSupport::JSON.decode(params[:record])

		# Check that they have a valid hash - uses the current_user.ScoreHash to decrypt the string
		begin
			key = EzCrypto::Key.with_password(APP_CONFIG["SECRET"]["TOKEN"], params[:level_id], :algorithm => 'blowfish')
			request_time = key.decrypt64(score_hash)
			puts "RequestTime" << request_time
			level_request_time = Time.at(request_time.to_i)
		rescue Exception=>e
			render :json => ['notice' => 'Error 501', 'status' => false] and return
		end

		# One of the entries in the record has a greater time than the score they're trying to submit
		recording.each do |record|
			if record['t'].to_i > score
				render :json => ['notice' => 'Error 503', 'status' => false] and return
			end
		end

		# Only 3 or less recording states - this is pretty impossible co
		render(:json => ["notice" => "Error 505", "status" => false]) and return unless recording.length > 3

		# Made it far enough to count as valid, increment times played
		@level = Level.find(params[:level_id])
		@level.update_attribute(:times_played, @level.times_played+1)

		# Check if the user already has a record for this level
		previous_score = Highscore.order('score').find_by_user_id_and_level_id(current_user.id, params[:level_id]) # with dynamic finder

		begin
			# They don't have a score for this level
			if previous_score.nil?
				# Save the score
				@highscore = @level.highscores.build
				@highscore.user_id = current_user.id
				@highscore.score = score
				@highscore.playerRecord = ActiveSupport::JSON.encode(recording)
				@highscore.save
			else # Update level entry
				render(:json => ["notice" => "Previous score better", "status" => false]) and return unless previous_score.score.to_i > score
				previous_score.score = score.to_s
				previous_score.playerRecord = ActiveSupport::JSON.encode(recording)
				previous_score.save
			end
		rescue Exception=>e
			render :json => ["notice" => e, "status" => false]
		end


		# Alright it worked!
		render :json => ["notice" => "Score saved", "status" => true]
	end
end