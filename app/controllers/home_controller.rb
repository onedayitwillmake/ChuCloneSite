class HomeController < ApplicationController
  def index
    flash[:notice] = []
    flash[:notice] << 'Flash:Notice - worked'
    flash[:notice] << 'Flash:Notice - worked'
  end

end
