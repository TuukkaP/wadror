require 'spec_helper'
include OwnTestHelper

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    user.username.should == "Pekka"
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "is not created with incorrect password" do
    it "which has no numbers" do
      user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "which has no capital letters" do
      user = User.create username:"Pekka", password:"secret1", password_confirmation:"secret1"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "which is too short" do
      user = User.create username:"Pekka", password:"S1", password_confirmation:"S1"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }
    let(:style){FactoryGirl.create(:style) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end

    it "is the favorite style" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = FactoryGirl.create(:beer, style:style)
      rating = FactoryGirl.create(:rating, score:40,  beer:best, user:user)
      expect(user.favorite_style.name).to eq(best.style.name)
    end

    it "is the favorite brewery" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      brewe = FactoryGirl.create(:brewery, name:"Paras panimo")
      best = FactoryGirl.create(:beer, brewery:brewe)
      rating = FactoryGirl.create(:rating, score:40,  beer:best, user:user)
      expect(user.favorite_brewery.name).to eq(brewe.name)
    end
  end
end
#describe "when initialized with name Schlenkerla and year 1674" do
#  subject{ Brewery.create name: "Schlenkerla", year: 1674 }
#
#  it { should be_valid }
#  its(:name) { should eq("Schlenkerla") }
#  its(:year) { should eq(1674) }
#end