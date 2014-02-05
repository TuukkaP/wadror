require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Aapeli" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "users ratings are all shown on the ratings page" do
    create_beers_with_ratings(12,2,3,41,5, user)
    create_beers_with_ratings(50,49, user2)
    visit ratings_path
    expect(page).to have_content 'Number of ratings: 7'
    expect(page).to have_content '12'
    expect(page).to have_content '41'
    expect(page).to have_content '49'
    expect(page).to have_content '50'
  end

  it "user can delete own ratings" do
    create_beers_with_ratings(12,2,3,41,5, user)
    create_beers_with_ratings(50,49, user2)
    visit ratings_path
    page.all(:link,"delete")[3].click
    expect(page).not_to have_content '41'
    expect(page).to have_content 'Number of ratings: 6'
  end

  it "users own ratings are shown in user show page" do
    create_beers_with_ratings(12,2,3,41,5, user)
    create_beers_with_ratings(50,49, user2)
    visit user_path(user)
    expect(page).to have_content 'has made 5 ratings, average rating 12.6'
    expect(page).not_to have_content '49'
  end
end