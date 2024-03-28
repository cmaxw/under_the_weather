class Weather
  attr_reader :data, :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
    set_current_weather
  end

  # temperature comes in Kelvin. This converts it to fahrenheit.
  def temperature_in_fahrenheit
    @temperature_in_fahrenheit ||= (data['main']['temp'] / 0.55555556 - 459.67).round
  end

  # feels like temperature comes in Kelvin. This converts it to fahrenheit.
  def feels_like_in_fahrenheit
    @feels_like_in_fahrenheit ||= (data['main']['feels_like'] / 0.55555556 - 459.67).round
  end

  def description
    data['weather'].first['description'].titleize
  end

  def icon_url
    icon = data['weather'].first['icon']
    "https://openweathermap.org/img/wn/#{icon}@4x.png"
  end

  def cached?
    @cached
  end

  private

  def set_current_weather
    @cached = true
    @data = Rails.cache.fetch(['weather', latitude, longitude], expires_in: 30.minutes) do
      @cached = false
      connection = Faraday.new
      response = connection.get("https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
      JSON.parse(response.body)
    end
  end
end
