class GameController < ApplicationController
  def index
	  @levels = Level.all(:order => "order_index")
  end

  def edit
	  if not params[:id].nil?
	  	@level = Level.find(params[:id])
	  end
  end

end
