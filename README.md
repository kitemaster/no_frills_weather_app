# README

This is a simple weather app that uses the OpenWeatherMap API to get the current weather for a given address. It is 
built using Ruby on Rails.

Here is what you need to do to get it running:

* Ruby version
  - 3.1.3

* Rails version
  - 7.0.8

* Test Framework
  - RSpec

* System dependencies
  - It's a simple app, so you don't need to install anything else. You will be good to go after you install Ruby and bundle install

* Functionality
  - The app has a simple search form that take a city name or zip code and returns the current weather for that location
  - It uses the OpenWeatherMap API to get the weather data
  - The data is cached for 30 minutes to avoid hitting the API too often

* Testing
  - The app has a few automated tests to make sure the API is working as expected
  - There is more opportunity to add tests, covering caching, and other negative cases and edge cases, but I wanted to keep it simple for this exercise
  - You can run the tests with `rspec`
  
* API Key
  - The API key is encrypted and stored in credentials.yml.enc. You will need to add your own API key to the credentials file to get the app working
  - Remove config/master.key and config/credentials.yml.enc
  - Get a free API key at https://openweathermap.org/api
  - Run EDITOR="vim" rails credentials:edit in the terminal: This command will create a new master.key and credentials.yml.enc
  - Add the following to the credentials file:
  - ```
    open_weather_map:
      api_key: YOUR_API_KEY
  ```
* 
* ...
