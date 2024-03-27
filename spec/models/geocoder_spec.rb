require 'rails_helper'

RSpec.describe Geocoder, type: :model do
  it 'returns cached latitude and longitude from the database' do
    create(:geocoder, postal_code: '84043', latitude: '40.40680', longitude: '-111.87011')
    expect(Faraday).not_to receive(:get)
    latitude, longitude = Geocoder.geocode(postal_code: '84043')
    expect(latitude).to eq('40.40680')
    expect(longitude).to eq('-111.87011')
  end

  it 'returns cached latitude and longitude from a geocoding service' do
    VCR.use_cassette('geocode_provo') do
      latitude, longitude = Geocoder.geocode(postal_code: '84604')
      expect(latitude).to eq('40.27759')
      expect(longitude).to eq('-111.65065')
    end
  end
end
