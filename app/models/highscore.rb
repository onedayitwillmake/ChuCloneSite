class Highscore < ActiveRecord::Base
  belongs_to :level
  belongs_to :user

  # TODO: REMOVE NEED FOR INSTANCE VARIABLE IN MODEL
	attr_accessor :current_user

  #validate :must_be_logged_in

  ## Modify the user before it is saved to the DB to set the auth properties
  #def self.create_with_score_and_record(auth)
  #  create! do |user|
  #    user.provider = auth['provider']
  #    user.uid = auth['uid']
  #    user.name = auth['user_info']["nickname"]
  #  end
  #end

    #
    #is_valid_score = true
    #
    #score = params[:score]
    #recording = ActiveSupport::JSON.decode(params[:record])
    #
    #begin
    #key = EzCrypto::Key.with_password(APP_CONFIG["SECRET"]["TOKEN"], params[:level_id], :algorithm => 'blowfish')
    #level_request_time = Time.at(key.decrypt64(current_user.ScoreHash).to_i)
    #current_time = Time.now
    #minscore = current_time - level_request_time - level_animation_time
    #
    #
    #recording.each do |record|
    #
    #end
    #
    #recording.last['t'].to_i
    #@level = Level.find(params[:level_id])
    #@highscore = @level.highscores.build
    #@highscore.user_id = current_user.uid
    #@highscore.score = score
    #@highscore.playerRecord = ActiveSupport::JSON.encode(recording)
    #@highscore.save

  #def valid_recording
  #
  #end
  #
  #def must_be_logged_in
	#	if @current_user.nil? && self.current_user.nil? then
	#		errors.add("User", "Not logged in!")
	#	end
	#end
end
