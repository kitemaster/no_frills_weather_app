require 'spec_helper'
require 'rails_helper'

describe "Home Page" do

    it "should have a link to the home page" do
      visit '/'
      expect(page).to have_link('Home', '/')
    end

    it "should have a link to the about page" do
      visit '/'
      expect(page).to have_link('About', '/about')
    end

    it "should have the right h1 heading" do
      visit '/'
      expect(page).to have_selector('h1', :text => 'No Frills Weather App')
    end


end