class GameController < ApplicationController
  def index
	  @levels = Level.all(:order => "order_index")
  end

  def edit
  end

end
