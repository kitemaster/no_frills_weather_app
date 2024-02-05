require 'spec_helper'
require 'rails_helper'

describe "Home Page" do

  let(:base_api_url) { "https://api.openweathermap.org" }
  let(:open_weather_map_client) { OpenWeatherMapClient.new }
  let(:partial_address) { 'Eagan' }

  let(:matching_addresses) {
    [
      {
        "name" => "Eagan",
        "lat" => 44.818173,
        "lon" => -93.1659179,
        "country" => "US",
        "state" => "Minnesota"
      },
      {
        "name" => "Eagan",
        "lat" => 36.5520248,
        "lon" => -83.9768682,
        "country" => "US",
        "state" => "Tennessee"
      }].to_json
  }

  it "should have a link to the home page" do
    visit '/'
    expect(page).to have_link('No Frills Weather App', :href => '/')
  end

  it "should have the right h1 heading" do
    visit '/'
    expect(page).to have_selector('h1', :text => 'No Frills Weather App')
  end

  it "should have a input text box for the address" do
    visit '/'
    expect(page).to have_selector('input[type="text"]')
  end

  it "should return matching addresses when the user types in the address" do
    pending 'works in the development but need to fix the test case'
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

    visit '/'
    fill_in 'address', with: 'eagan'
    expect(page).to have_selector('div', :text => 'eagan, Minnesota, US')
  end

  # Need to write this test case
  it "shows the weather for selected location from the autocomplete suggestions" do

  end

end