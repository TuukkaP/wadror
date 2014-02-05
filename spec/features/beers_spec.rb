require 'spec_helper'
include OwnTestHelper

describe "Beer" do

  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create(:style, name:"IPA")
    FactoryGirl.create(:brewery, name:"BrewDog")
    FactoryGirl.create(:beer, name:"Karhu III")
    FactoryGirl.create(:beer)
  end


    it "can be created if beer is valid" do
      visit new_beer_path
      fill_in('beer_name', with:'olut')
      select('IPA', :from => 'beer_style_id')
      select('BrewDog', :from => 'beer_brewery_id')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

  it "cannot be created if beer is invalid" do
    visit new_beer_path
    select('IPA', :from => 'beer_style_id')
    select('BrewDog', :from => 'beer_brewery_id')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content 'Name can\'t be blank'
    #save_and_open_page
  end

end