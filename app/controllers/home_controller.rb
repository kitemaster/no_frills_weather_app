class HomeController < ApplicationController
  before_action :initialize_open_weather_map_client
  def index
  end

  def address_search
    @matching_addresses = @open_weather_map_client.get_matching_addresses(params[:address])

    if @matching_addresses.present?
      @matching_addresses
    else
      if zip_or_postal_code?(params[:address])
        redirect_to weather_for_zipcode_path(zip: params[:address])
      else
        flash[:notice] = "No matching addresses found for #{params[:address]}"
        redirect_to root_path
      end
    end
  end

  def weather_for_location
    @city = params[:name]
    @state = params[:state]
    @country = params[:country]
    @weather = @open_weather_map_client.get_weather_for_location(params[:lat], params[:lon])
  end

  def weather_for_zipcode
    @zip = params[:zip]
    @weather = @open_weather_map_client.get_weather_for_zipcode_and_country_code(@zip, 'US')
    render :weather_for_location
  end

  private
  def initialize_open_weather_map_client
    @open_weather_map_client ||= OpenWeatherMapClient.new
  end

  def zip_or_postal_code?(zip)
    zip =~ /\A\d{5}-\d{4}|\A\d{5}\z/
  end
end