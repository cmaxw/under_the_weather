class Geocoder < ApplicationRecord
  validates :latitude, :longitude, presence: true

  def self.geocode(address: nil, city: nil, state: nil, country: nil, postal_code: nil)
    cached_version = find_by(address:, city:, state:, country:, postal_code:)
    return [cached_version.latitude, cached_version.longitude] if cached_version

    address_to_geocode = URI.encode_www_form_component([address, [city, state, country].compact.join(', '),
                                                        postal_code].compact.join(' '))
    connection = Faraday.new
    response = connection.get("https://geocode.xyz/#{address_to_geocode}?auth_code=#{ENV['GEOCODE_AUTH_CODE']}&json=1")
    response_values = JSON.parse(response.body)
    geocoder = create(address:, city:, state:, country:, postal_code:, latitude: response_values['latt'],
                      longitude: response_values['longt'])
    [geocoder.latitude, geocoder.longitude]
  end
end
