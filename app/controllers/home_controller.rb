class HomeController < ApplicationController
  def index; end

  def weather
    redirect_to root_path
  end
end
