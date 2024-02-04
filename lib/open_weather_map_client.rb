class OpenWeatherMapClient

  BASE_URL = 'https://api.openweathermap.org'

  def initialize
    @api_key = Rails.application.credentials.open_weather_map.api_key
  end

  def get_longitude_and_latitude_for_zipcode(zip_code, country_code)
    HTTParty.get("#{BASE_URL}/geo/1.0/zip?zip=#{zip_code}},#{country_code}&appid=#{@api_key}")
  end

  def get_weather_for_zipcode_and_country_code(zip_code, country_code)
    longitude_and_latitude = get_longitude_and_latitude_for_zipcode(zip_code, country_code)
    binding.pry
    HTTParty.get(
      "#{BASE_URL}/data/3.0/onecall?lat=#{longitude_and_latitude['lat']}&lon=#{longitude_and_latitude['lon']}"\
       "&exclude=minutely&units=imperial&appid=#{@api_key}"
    )
  end

end
