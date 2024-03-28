class HomeController < ApplicationController
  def index; end

  def weather
    @address = params[:address]
    @city = params[:city]
    @state = params[:state]
    @postal_code = params[:postal_code]
    @country = params[:country]

    @latitude, @longitude = Geocoder.geocode(address: @address,
                                             city: @city,
                                             state: @state,
                                             postal_code: @postal_code,
                                             country: @country)

    @weather = Weather.new(@latitude, @longitude)
    render :index
  end
end
