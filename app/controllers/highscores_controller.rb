require 'ezcrypto'
class HighscoresController < ApplicationController
  def new
    #redirect_to game_index_path and return unless current_user
    @level = Level.find(params[:level_id])
    @highscore = @level.highscores.build
    @highscore.user_id = current_user.uid
    @highscore.score = params[:score]
    @highscore.playerRecord = params[:record]
    @highscore.save



    key = EzCrypto::Key.with_password(APP_CONFIG["SECRET"]["TOKEN"], APP_CONFIG["SECRET"]["SALT"], :algorithm => 'blowfish')
    timestamp = Time.at(key.decrypt64(current_user.ScoreHash).to_i)
    oldstamp = Time.now



    #key = EzCrypto::Key.with_password(APP_CONFIG["SECRET"]["TOKEN"], APP_CONFIG["SECRET"]["SALT"], :algorithm => 'blowfish')
    #score = key.decrypt64(current_user.ScoreHash)
    #a_date = Date.parse(score);

    render :json => oldstamp-timestamp
  end
end