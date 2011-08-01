class HighscoresController < ApplicationController
  def new
    @level = Level.find(params[:level_id])
    @highscore = @level.highscores.build
    @highscore.user_id = current_user.id
    @highscore.score = 123.2
    @highscore.save

    #raise @highscore.to_yaml
    #redirect_to @level
  end
end

#/**
#class CommentsController < ApplicationController
#  def create
#    @video = Video.find params[:video_id]
#    @comment = @video.comments.build params[:comment]
#
#    redirect_to @video
#  end
#end
#*/
