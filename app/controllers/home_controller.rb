class HomeController < ApplicationController
  def index; end

  def weather
    @address = params[:address]
    @city = params[:city]
    @state = params[:state]
    @postal_code = params[:postal_code]
    @country = params[:country]

    render :index
  end
end
