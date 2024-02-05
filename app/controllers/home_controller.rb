class HomeController < ApplicationController
  before_action :initialize_open_weather_map_client
  def index
  end

  def address_search
    @matching_addresses = @open_weather_map_client.get_matching_addresses(params[:address])
  end

  def weather_for_location
    @city = params[:name]
    @state = params[:state]
    @country = params[:country]
    @weather = @open_weather_map_client.get_weather_for_location(params[:lat], params[:lon])
  end

  private
  def initialize_open_weather_map_client
    @open_weather_map_client ||= OpenWeatherMapClient.new
  end
end