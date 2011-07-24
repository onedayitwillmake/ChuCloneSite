class HomeController < ApplicationController
	layout ="home"
  def index
	  render :file => "#{RAILS_ROOT}/public/game/EditMode.html"
  end

end
