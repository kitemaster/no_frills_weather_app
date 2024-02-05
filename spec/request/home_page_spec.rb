require 'spec_helper'
require 'rails_helper'

describe "Home Page" do

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
      visit '/'
      binding.pry
      fill_in 'address', with: '55122'
      expect(page).to have_selector('div.ui-menu-item')
    end

end