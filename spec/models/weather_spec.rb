require 'rails_helper'

RSpec.describe Weather, type: :model do
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  it 'returns cached latitude and longitude from the database' do
    VCR.use_cassette('weather_84043') do
      weather = Weather.new('40.40680', '-111.87011')
      expect(weather.temperature_in_fahrenheit).to eq(47)
      expect(weather.feels_like_in_fahrenheit).to eq(43)
      expect(weather.description).to eq('Overcast Clouds')
      expect(weather.icon_url).to match(/04n@4x.png/)
      expect(weather.cached?).to be_falsy
    end

    expect(Faraday).not_to receive(:get)
    second_weather = Weather.new('40.40680', '-111.87011')
    expect(second_weather.cached?).to be_truthy
  end
end
