require 'rails_helper'
require 'spec_helper'

describe OpenWeatherMapClient do

  let(:base_api_url) { "https://api.openweathermap.org" }
  let(:open_weather_map_client) { OpenWeatherMapClient.new }
  let(:successful_response_body_for_geocoding_api) { { zip: "55122", name: "Eagan", lat: 44.786, lon: -93.2202, country: "US" }.to_json }
  let(:successful_raw_response_file_for_weather_api) { File.new("#{Rails.root}/spec/fixtures/successful_open_weather_map_response.txt") }
  let(:partial_address) { 'Eagan' }
  let(:matching_addresses) { [{"name"=>"Eagan", "lat"=>44.818173, "lon"=>-93.1659179, "country"=>"US", "state"=>"Minnesota"}, {"name"=>"Eagan", "lat"=>36.5520248, "lon"=>-83.9768682, "country"=>"US", "state"=>"Tennessee"}] .to_json }

  before(:each) do
    stub_request(
      :get,
      "#{base_api_url}/geo/1.0/zip?appid=#{Rails.application.credentials.open_weather_map.api_key}"\
        "&zip=55122%7D,us"
    ).with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Ruby'
      }).
      to_return(
        status: 200,
        body: successful_response_body_for_geocoding_api,
        headers: { content_type: 'application/json' }
      )
  end

  describe '#get_longitude_and_latitude_for_zipcode' do
    it 'should return longitude and latitude for a given zip code and country code' do

      response = open_weather_map_client.get_longitude_and_latitude_for_zipcode(55122, 'us')
      expect(response.code).to be 200
      expect(response['lon']).to be -93.2202
      expect(response['lat']).to be 44.786
    end
  end

  describe '#get_weather_for_zipcode' do
    it 'should return weather for the give zip code and country code' do
      stub_request(
        :get,
        "#{base_api_url}/data/3.0/onecall?appid=#{Rails.application.credentials.open_weather_map.api_key}"\
          "&exclude=minutely&lat=44.786&lon=-93.2202&units=imperial"
      ).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }).
        to_return(successful_raw_response_file_for_weather_api)

      response = open_weather_map_client.get_weather_for_zipcode_and_country_code(55122, 'us')
      expect(response.code).to be 200
      expect(response['current']['temp']).to be 44.44
    end
  end

  describe '#get_matching_cities_and_zip_codes' do
    it 'should return matching cites and zip codes given partial address' do
      stub_request(
        :get,
        "#{base_api_url}/geo/1.0/direct?q=#{partial_address}&limit=5&appid="\
          "#{Rails.application.credentials.open_weather_map.api_key}"
      ).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }).
        to_return(
          status: 200,
          body: matching_addresses,
          headers: { content_type: 'application/json' }
        )

      response = open_weather_map_client.get_matching_addresses(partial_address)
      expect(response.code).to be 200
      expect(response.count).to be 2
      expect(response.first['name']).to eq 'Eagan'
    end
  end

end
